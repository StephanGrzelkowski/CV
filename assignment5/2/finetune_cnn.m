function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
%run(fullfile(fileparts(mfilename('fullpath')), ...
    %'..', '..', '..', 'matlab', 'vl_setupnn.m')) ;
    
run('/home/stephan/Documents/MATLAB/MatConvNet/matlab/vl_setupnn.m')

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
    sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-stl.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = [];



%% update model

net = update_model();

%% TODO: Implement getIMDB function below

if exist(opts.imdbPath, 'file')
    imdb = load(opts.imdbPath) ;
else
    imdb = getIMDB('../stl10_matlab/') ; %change this one depending on where the STL10 dataset is
    mkdir(opts.expDir) ;
    save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
    'expDir', opts.expDir, ...
    net.meta.trainOpts, ...
    opts.train, ...
    'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
    case 'simplenn'
        fn = @(x,y) getSimpleNNBatch(x,y) ;
    case 'dagnn'
        bopts = struct('numGpus', numel(opts.train.gpus)) ;
        fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getIMDB(path_stl)
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'birds', 'ships', 'horses', 'cars'};
splits = {'train', 'test'};

%loop through training and test sets
for it_set = 1 : 2
    cur_set = splits{it_set};
    dat = load([path_stl, cur_set , '.mat']);
    
    %on the first set
    
    % create a list of the target labels
    ls_labels = nan(length(classes), 1);
    for it = 1 : length(classes)
        idx_class = find(strcmp(classes{it}(1 : end-1), dat.class_names)); %removing the 's' in classes and then finding match
        ls_labels(it) = idx_class;
    end
    
    
    %skip all images that aren't of the target labels
    idcs_target_images = find(ismember(dat.y, ls_labels));
    
    %preappend for speed
    cur_data = nan(32,32, 3, length(idcs_target_images));
    cur_labels = nan(1, length(idcs_target_images));
    
    for it = 1 : size(idcs_target_images, 1)
        cur_idx = idcs_target_images(it);
        %don't know why it says 32 in the comment above should be 96 if we're still working with
        %STL-10
        img = reshape(dat.X(cur_idx,:), [96, 96, 3]);
        
        %resize the image 
        img = imresize(img,1/3);
        
        %write image to data structure after norm and data type transf.
        cur_data(:,:,:,it) = single(img ./ 255);
        
        %get the label
        label = find(ls_labels == dat.y(cur_idx));
        
        cur_labels(it) = label;
    end
    
    data_sets{it_set} = cur_data;
    labels_sets{it_set} = cur_labels;
    
    %write the sets vector
    if it_set == 1
        sets(1 : length(idcs_target_images)) = 1;
    else
        sets(end+1 : end + length(idcs_target_images)) = 2;
    end
end

%stitch the data together
data = cat(4, data_sets{1}, data_sets{2});
labels = cat(2, labels_sets{1}, labels_sets{2});

%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = single(data);
imdb.images.labels = single(labels) ;
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end
