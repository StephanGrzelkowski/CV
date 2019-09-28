% Desktop
% image = imread('D:\Google accounts\Student account\School\Master AI\Computer Vision 1\Lab assignments\Assignment 2\part1_image_enhancement\images\image2.jpg');
% Laptop
%image = imread('C:\Users\Sander\Desktop\git\CV\assignment2\part1_image_enhancement\images\image2.jpg');
% [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image);

% imwrite(Gx, 'Q8_gx.png');
% imwrite(Gy, 'Q8_gy.png');
% imwrite(im_magnitude, 'Q8_mag.png');
% imwrite(im_direction, 'Q8_dir.png');

imOut1 = compute_LoG(image, 1);
imOut2 = compute_LoG(image, 2);
imOut3 = compute_LoG(image, 3);

figure;
subplot(1,3,1);
imshow(imOut1);
subplot(1,3,2);
imshow(imOut2);
subplot(1,3,3);
imshow(imOut3);

%save the images
% imwrite(imOut1, 'Q9_imout1.png');
% imwrite(imOut2, 'Q9_imout2.png');
% imwrite(imOut3, 'Q9_imout3.png');