%    Read original image and a noisy image, and convert them to double-precision float type
orig_im = imread('C:\Users\whitn\OneDrive\Documenten\COMPVISION-GRRRRRRRRR\assignment2\part1_image_enhancement\images\image1.jpg');
orig_im = im2double(orig_im);
saltpepper = imread('C:\Users\whitn\OneDrive\Documenten\COMPVISION-GRRRRRRRRR\assignment2\part1_image_enhancement\images\image1_saltpepper.jpg');
gaussian = imread('C:\Users\whitn\OneDrive\Documenten\COMPVISION-GRRRRRRRRR\assignment2\part1_image_enhancement\images\image1_gaussian.jpg');
im = gaussian; % specify which noisy image we want to play with right now
im = im2double(im);

%   Specificy the type of filter
%kernel_type = 'box';
%kernel_type = 'median';
kernel_type = 'gaussian';

%       If 'gaussian', also specificy sigma
sigma = 1;

%   Specify kernel size
kernel_size =   3; % k. Size of kernel almong one dimension. We test 3x3, 5x5 and 7x7

%   Apply the denoising algorithm and visualize the denoised image
%denoised_im = denoise(im, kernel_type, kernel_size);
denoised_im = denoise(im, kernel_type, sigma, kernel_size);

plot(denoised_im), imshow(denoised_im);

%   Measure how well the denoising algorithm did
PSNR = myPSNR(orig_im, denoised_im)