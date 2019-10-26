function [sorted, indexes] = sortOutput(probs, classes_text, x_test)
% This function sorts all of the probabilities columnwise.
n_classes = length(classes_text);   
sorted = nan(size(probs));
indexes = nan(size(probs));

for i = 1:n_classes
    [B, index] = sortrows(probs(:, i), 1, 'descend');
    figure;
    suptitle("Top row = five highest, bottow row = five lowest ranked for class " + classes_text(i));
    for j = 1:5
        subplot(2,5,j);
        imshow(x_test(:,:,:,index(j)));
        subplot(2,5,j+5)
        imshow(x_test(:,:,:,index(end-j)));
    end

    sorted(:, i) = B;
    indexes(:,i) = index;
end