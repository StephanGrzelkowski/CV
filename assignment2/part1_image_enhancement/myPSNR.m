function [ PSNR ] = myPSNR( orig_image, approx_image )
orig_image = im2double(orig_image);
approx_image = im2double(approx_image);
m = size(orig_image, 1);
n = size(orig_image, 2);
MSE = ( 1/(m*n) ) * sum((orig_image - approx_image).^2,'all');
Imax = max(orig_image,[],'all');
PSNR = 20 * log10(Imax/sqrt(MSE));
end