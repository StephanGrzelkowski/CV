function subset = loadData(type, N, classes)
% Function to load data | input: 'training' or 'test' | N is size of data
% (max 2500 for train, max 4000 for test)
data = load(['./stl10_matlab/' , type , '.mat']);

% Filter out the classes
indexes = ismember(data.y, classes);
all_data = [data.y(indexes), data.X(indexes, :)];
sorted_data = sortrows(all_data);

% Equal number of images for every class are required. All classes are
% sorted and N random samples are added to the subset.
N_per_class = N / length(classes);
subset = nan(0, size(all_data, 2));  
for i = classes
    class_indexes = find(sorted_data(:,1) == i);
    class_data = sorted_data(class_indexes, :);
    idx = randperm(size(class_data,1));
    class_subset = class_data(idx,:);
    class_subset = class_subset(1:N_per_class, :);
    subset = vertcat(subset, class_subset);
end

% % Reshape into the right sizes
% x_vec = subset(:, 2:size(subset, 2));
% y = subset(:, 1);
% x = nan(96,96,3,N); 
% for it = 1 : N
%     x(:,:,:,it) = reshape(squeeze(x_vec(it, :)), 96, 96, 3);
% end

end