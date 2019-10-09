function [ stitched ] = stitch(im1,im2)
[matches, scores, f1, f2] = keypoint_matching(im2, im1);
N = 30;
P = 10;

% shuf_match = matches(:, randperm(size(matches,2)));
% subset = shuf_match(:, (1:P));
% x1 = f1((1), subset(1,:));
% y1 = f1((2), subset(1,:));
% 
% x2 = f2((1), subset(2,:));
% y2 = f2((2), subset(2,:));
% X = zeros(6,P);
% for i = 1:P
%     a = [x2(i),y2(i),  0,    0,  1,0;
%          0,   0,    x2(i),y2(i), 0,1];
%     b =[x1(i);y1(i)];
%     x = pinv(a)*b;
%     X(:,i) = x;
% end
% 
%


best_t = RANSAC(matches, f1, f2, N, P);
tform = affine2d(best_t');
zz = imwarp(im2, tform, 'nearest');
% s1 = size(im1);
% s2 = size(im2);
% new2 = zeros(s1);
% diff = floor((s1-s2)./2);
% new2(diff(1)+1:diff(1)+s2(1),diff(2)+1:diff(2)+s2(2)) = im2;
% 
% 
% 
% 
% 
% [x,y] = meshgrid(1:s1(1), 1:s1(2));
% coords = [reshape(x,1,[]);reshape(y,1,[]);ones(1,s1(1)*s1(2))];
% c = best_t * coords;
% XcoordNew = round(c(1,:));
% YcoordNew = round(c(2,:));
% new = zeros(s1(1)*s1(2),1);
% for i = 1:s1(1)*s1(2)
%     if [XcoordNew(i),YcoordNew(i)] < s1 & [XcoordNew(i),YcoordNew(i)] >= [1,1]
%         new(i) = new2(XcoordNew(i),YcoordNew(i));
%     else
%         new(i) = 0;
%     end
% end
% %new = arrayfun(@(y,x) pixelValue(new2,x,y),XcoordNew,YcoordNew);
% zz = reshape(new,[s1(1),s1(2)]);

figure;
imshow(uint8(zz));
hold on
size(zz)
s1 = size(im1);
s2 = size(zz);
n1 = zeros(600,600);
n2 = zeros(600,600);

dif1 = round(([600,600]-s1)./2);
dif2 = round(([600,600]-s2)./2);

n1(dif1(1)+1:dif1(1)+s1(1),dif1(2)+1:dif1(2)+s1(2)) = im1;
n2(dif2(1)+1:dif2(1)+s2(1),dif2(2)+1:dif2(2)+s2(2)) = zz;
stitched = [n1,n2];

end