load('train.mat');
N = 1000;
P = 5;
X = X(1:N,:);
siftt = [];
for i =1:N
    im = reshape(X(i,:),96,96,3);
    [feat,desc] = vl_sift(single(rgb2gray(im)));
    siftt = [siftt,desc];
end

[coeff,score,latent,a,ex] = pca(double(siftt'));
size(score)

figure;
plot(score(:,1),score(:,2),'o','MarkerSize',5);
title 'test';
xlabel 'PCA 1'; 
ylabel 'PCA 2';
