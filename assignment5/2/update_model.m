function net = update_model(batch_size, epochs, varargin)
opts.networkType = 'simplenn' ;
%opts = vl_argparse(opts, varargin) ;


%% TODO: PLAY WITH THESE PARAMETERTS TO GET A BETTER ACCURACY

lr_prev_layers = [.2, 2];
lr_new_layers  = [1, 4]; 

lr = lr_prev_layers ;

% Meta parameters
net.meta.inputSize = [32 32 3] ;
net.meta.trainOpts.learningRate = [ 0.05*ones(1,epochs(1)) ...
                                    0.005*ones(1,epochs(2))...
                                    0.0005*ones(1,epochs(3))...
                                    ] ;
net.meta.trainOpts.weightDecay = 0.0001 ;
net.meta.trainOpts.batchSize = batch_size ;
net.meta.trainOpts.numEpochs = numel(net.meta.trainOpts.learningRate) ;

%% Define network 
net.layers = {} ;

% Block 1
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{0.01*randn(5,5,3,32, 'single'), zeros(1, 32, 'single')}}, ...
                           'learningRate', lr, ...
                           'stride', 1, ...
                           'pad', 2) ;
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [3 3], ...
                           'stride', 2, ...
                           'pad', [0 1 0 1]) ;
net.layers{end+1} = struct('type', 'relu') ;

% Block 2
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{0.05*randn(5,5,32,32, 'single'), zeros(1,32,'single')}}, ...
                           'learningRate', lr, ...
                           'stride', 1, ...
                           'pad', 2) ;
net.layers{end+1} = struct('type', 'relu') ;
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'avg', ...
                           'pool', [3 3], ...
                           'stride', 2, ...
                           'pad', [0 1 0 1]) ; % Emulate caffe

% Block 3
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{0.05*randn(5,5,32,64, 'single'), zeros(1,64,'single')}}, ...
                           'learningRate', lr, ...
                           'stride', 1, ...
                           'pad', 2) ;
net.layers{end+1} = struct('type', 'relu') ;
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'avg', ...
                           'pool', [3 3], ...
                           'stride', 2, ...
                           'pad', [0 1 0 1]) ; % Emulate caffe

% Block 4
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{0.05*randn(4,4,64,64, 'single'), zeros(1,64,'single')}}, ...
                           'learningRate', lr, ...
                           'stride', 1, ...
                           'pad', 0) ;
net.layers{end+1} = struct('type', 'relu') ;

%% TODO: Define the structure here, so that the network outputs 5-class rather than 10 (as in the pretrained network)
% Block 5

% NEW_INPUT_SIZE  = X
% NEW_OUTPUT_SIZE = Y

%this should be from the previous layer right? 
NEW_INPUT_SIZE = 64;
%this should just be the number of classes 
NEW_OUTPUT_SIZE = 5; 

net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{0.05*randn(1,1,NEW_INPUT_SIZE,NEW_OUTPUT_SIZE, 'single'), zeros(1,NEW_OUTPUT_SIZE,'single')}}, ...
                           'learningRate', .1*lr_new_layers, ...
                           'stride', 1, ...
                           'pad', 0) ;

%%  Define loss                     
% Loss layer
net.layers{end+1} = struct('type', 'softmaxloss') ;

% Fill in default values
net = vl_simplenn_tidy(net) ;

oldnet = load('./data/pre_trained_model.mat'); oldnet = oldnet.net;
net = update_weights(oldnet, net);
end

%% Assign previous weights to the network
function newnet = update_weights(oldnet, newnet)

% loop until loss layer
for i = 1:numel(oldnet.layers)-2
    
    if(isfield(oldnet.layers{i}, 'weights'))
       
        newnet.layers{i}.weights = oldnet.layers{i}.weights;
        
    end
    
end

end

