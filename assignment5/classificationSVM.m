function probs = classificationSVM(x_train_hists, x_test_hists, y_train, y_test, classes)
% This function trains 5 one-vs-all support vector machine models, one for
% each class. Then it feeds the test images to all models and saves the 
% corresponding probability.  
n_labels = length(classes);
model = cell(n_labels,1);

% Train a model for each class (ONE vs ALL svm)
for i = 1:n_labels
    class_y_train = y_train == classes(i);
    temp_y = class_y_train .* y_train;
    model{i} = svmtrain(double(temp_y), x_train_hists, '-c 1 -g 0.2 -b 1 -q');
end

% Calculate the probability for all test images
probs = zeros(length(y_test),n_labels);
for i = 1:n_labels
    class_y_test = y_test == classes(i);
    temp_y = class_y_test .* y_test;
    [~, ~, prob] = svmpredict(double(temp_y), x_test_hists, model{i}, '-b 1 -q');
    probs(:,i) = prob(:, model{i}.Label==classes(i));
end

% %% predict the class with the highest probability
% [~,pred1] = max(probs,[],2);
% pred3 = classes(pred1)';
% acc = sum(pred3 == y_test) ./ numel(y_test);    %# accuracy

end

