function [x, y] = loadData(type, N)
% Function to load data | input: 'training' or 'test' | N is size of data
% (max 2500 for train, max 4000 for test)
data = load(['./stl10_matlab/' , type , '.mat']);

% These are the classes (airplanes, birds, ships, horses and cars)
% respectively
classes = [1, 2, 9, 7, 3];
indexes = ismember(data.y, classes);
y = data.y(indexes);
x_vec = data.X(indexes, :);

% Shuffle the image order
idx = randperm(length(y));
y = y(idx(1:N));
x = nan(96,96,3,N); 
for it = 1 : N
    
    x(:,:,:,it) = reshape(squeeze(x_vec(idx(it), :)), 96, 96, 3);
end
end