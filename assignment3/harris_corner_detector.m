function [thresh_mask, r, c] = harris_corner_detector(image, kernel_size, sigma, threshold)
% Image preprocessing
image2 = im2double(rgb2gray(image));
image2 = normalize(image2);

% Apply a gaussian filter and get the sobel derivatives
gauss = fspecial('gauss', kernel_size, sigma);
image2 = imfilter(image2, gauss, 'same');
[Gx,Gy] = imgradientxy(image2, 'sobel');

% Calculate Q Values
A = imgaussfilt(Gx.^2);
B = imgaussfilt(Gx.*Gy);
C = imgaussfilt(Gy.^2);

% Calculate H 
H = (A .* C - B.^2) - 0.04*(A + C).^2;

% Filter out local maximums
max_mask = imregionalmax(H);
H_max = H.*max_mask;

% Apply the threshold
thresh_mask = H_max > threshold;
[r, c] = find(thresh_mask);

% Plot the images
subplot(1,3,1);
imshow(Gx);
subplot(1,3,2);
imshow(Gy);
subplot(1,3,3);
imshow(image);

% Apply cornerpoints to image
for i = 1:length(r)
    h = images.roi.Circle(gca,'Center',[c(i) r(i)],'Radius',5);
end

end