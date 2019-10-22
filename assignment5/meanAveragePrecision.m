function map = meanAveragePrecision(probs, classes, ground_thruth, n_images)
n_classes = length(classes);   
n_image_class = n_images / n_classes;
aps = zeros(length(classes),1);


% Convert probabilities to predicted class by choosing highest value
[~,pred_classes] = max(probs,[],2);
pred_classes = classes(pred_classes)';

% Accuraccy
acc = sum(pred_classes == ground_thruth) ./ numel(ground_thruth);

end