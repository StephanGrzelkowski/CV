imRGB = imread('D:\Google accounts\Student account\School\Master AI\Computer Vision 1\Lab assignments\Assignment 1\color_constancy\awb.jpg');

red_channel = imRGB(:,:, 1);
green_channel = imRGB(:,:, 2);
blue_channel = imRGB(:,:, 3);

avg_red = mean(red_channel);
avg_green = mean(green_channel);
avg_blue = mean(blue_channel);

gray = 128 * ones(size(avg_red));

scale_red = gray/avg_red;
scale_green = gray/avg_green;
scale_blue = gray/avg_blue;

new_red = scale_red * red_channel;
new_green = scale_green * green_channel;
new_blue = scale_blue * blue_channel;

corrected_im = cat(3, new_red, new_green, new_blue);

subplot(1, 2, 1);
imshow(imRGB)
subplot(1, 2, 2);
imshow(corrected_im)