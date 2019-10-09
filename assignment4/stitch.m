function [ stitched ] = stitch(im1,im2)
[matches, scores, f1, f2] = keypoint_matching(im2, im1);
N = 30;
P = 10;
 
[best_t,best_m] = RANSAC(matches, f1, f2, N, P);
tform = affine2d(best_t');
zz = imwarp(im2, tform, 'nearest'); 

% figure;
% imshow(uint8(zz));
% hold on
% size(zz)
% s1 = size(im1);
% s2 = size(zz);
% n1 = zeros(600,600);
% n2 = zeros(600,600);

[matches, scores, f1, f2] = keypoint_matching(zz, im1);
[best_t,best_m] = RANSAC(matches, f1, f2, N, P);

xy_subset = f1((1:2) , best_m(1,:))
xy_subset2 = f2((1:2), best_m(2,:))

diffx = round(vecnorm(xy_subset(:,1) - xy_subset2(:,1))/2)
diffy = round(vecnorm(xy_subset(:,2) - xy_subset2(:,2))*2-50)

s1 = size(im1);
s2 = size(zz);
 m = best_t(1:2,1:2);
 t = best_t(3, 1:2);
[width_zz, height_zz] = Whitney(size(im2,1), size(im2,2), m, t)
nn = zeros(size(im1, 1)+width_zz-diffy, size(im1,2)+height_zz-diffx)
nn(50:s1(1)+49,1:s1(2)) = im1;
nn(50+s1(1)-diffy: 49+s1(1)-diffy+s2(1), s1(2) - diffx+1:  s1(2) - diffx+s2(2))= zz;

% dif1 = round(([600,600]-s1)./2);
% dif2 = round(([600,600]-s2)./2);
% 
% n1(dif1(1)+1:dif1(1)+s1(1),dif1(2)+1:dif1(2)+s1(2)) = im1;
% n2(dif2(1)+1:dif2(1)+s2(1),dif2(2)+1:dif2(2)+s2(2)) = zz;
stitched = nn;

end