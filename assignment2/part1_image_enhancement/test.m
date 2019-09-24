image = imread('D:\Google accounts\Student account\School\Master AI\Computer Vision 1\Lab assignments\Assignment 2\part1_image_enhancement\images\image2.jpg');
[Gx, Gy, im_magnitude,im_direction] = compute_gradient(image);

imwrite(Gx, 'Q8_gx.png');
imwrite(Gy, 'Q8_gy.png');
imwrite(im_magnitude, 'Q8_mag.png');
imwrite(im_direction, 'Q8_dir.png');

% imOut1 = compute_LoG(image, 1);
% imOut2 = compute_LoG(image, 2);
% imOut3 = compute_LoG(image, 3);
% 
% subplot(1,3,1);
% imshow(uint8(imOut1));
% subplot(1,3,2);
% imshow(uint8(imOut2));
% subplot(1,3,3);
% imshow(imOut3);

% imwrite(uint8(imOut1), 'Q9_imout1.png');
% imwrite(uint8(imOut2), 'Q9_imout2.png');
% imwrite(uint8(imOut3), 'Q9_imout3.png');