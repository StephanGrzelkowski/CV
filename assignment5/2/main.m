%% main function

%seup up hyperparameters batch_size and epochs for multiple runs:
batch_size = [50, 100];

epochs = {[20, 10, 10]}; %40 epochs
epochs{2} = epochs{1}.*2; %80 epochs
epochs{3} = epochs{1}.*3; %120 epochs

%save names for each net:
for it_batch = 1 : numel(batch_size)
    for it_epoch = 1 : length(epochs)
        str_save{it_batch * it_epoch} = sprintf('/new_model_batch_%i_epochs_%i',batch_size(it_batch), sum(epochs{it_epoch}));
    end
end
%% fine-tune cnn
%loop through all options

for it_batch = 1 : numel(batch_size)
    for it_epoch = 1 : length(epochs)
        [net, info, expdir] = finetune_cnn(batch_size(it_batch),epochs{it_epoch});
        save(fullfile([expdir, str_save{it_batch * it_epoch}, '.mat']), 'net')
        
        
        %% extract features and train svm
        
        % TODO: Replace the name with the name of your fine-tuned model
        nets.fine_tuned = load(fullfile([expdir, str_save{it_batch * it_epoch}, '.mat'])); nets.fine_tuned = nets.fine_tuned.net;
        nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net;
        data = load(fullfile(expdir, 'imdb-stl.mat'));
        
        
        %% run the svm classifier and store outputs
        [nn, svm] = train_svm(nets, data);
        accuracies_nn(it_batch, it_epoch) = nn.accuracy;
        accuracies_pre_trained(it_batch, it_epoch) =  svm.pre_trained.accuracy(1);
        accuracies_fine_tuned(it_batch, it_epoch) = svm.fine_tuned.accuracy(1);
        
        
        %% plot the tsne of the features and save the figure
        
        figure('units','normalized','outerposition',[0 0 1 1]);
        
        %pre trained train set
        subplot(221)
        Y = tsne(full(svm.pre_trained.trainset.features));
        gscatter(Y(:,1), Y(:,2), svm.pre_trained.trainset.labels)
        xlabel('tsne 1 (au)')
        ylabel('tsne 2 (au)')
        title(sprintf('Pre-trained network features; train set'))
        
%         pre_trained test set
        subplot(222)
        Y = tsne(full(svm.pre_trained.testset.features));
        gscatter(Y(:,1), Y(:,2), svm.pre_trained.testset.labels)
        xlabel('tsne 1 (au)')
        ylabel('tsne 2 (au)')
        title(sprintf('Pre-trained network features; test set'))
        
        %fine-tuned train set
        subplot(223)
        Y = tsne(full(svm.fine_tuned.trainset.features));
        gscatter(Y(:,1), Y(:,2),svm.fine_tuned.trainset.labels )
        xlabel('tsne 1 (au)')
        ylabel('tsne 2 (au)')
        title(sprintf('Fine-tuned network features; train set'))
        
        %fine-tuned test set
        subplot(224)
        Y = tsne(full(svm.fine_tuned.testset.features));
        gscatter(Y(:,1), Y(:,2),svm.fine_tuned.testset.labels )
        xlabel('tsne 1 (au)')
        ylabel('tsne 2 (au)')
        title(sprintf('Fine-tuned network features; test set'))
        
        %super title 
        sgtitle(sprintf('size: %i; epochs: %i', batch_size(it_batch), epochs{it_epoch}))
        
        %save the figure
        saveas(gcf, fullfile(expdir, str_save{it_batch * it_epoch}), 'png')
        saveas(gcf, fullfile(expdir, str_save{it_batch * it_epoch}), 'pdf')
        saveas(gcf, fullfile(expdir, str_save{it_batch * it_epoch}), 'fig')
        
        close gcf
        
        
    end
end