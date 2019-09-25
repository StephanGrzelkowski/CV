% ============================= 4.2 Image denoising ====================
%                   ======== 4.2.1 Quantitative evaluation =======

%            ====== Question 6.2 ======
orig_im = imread('C:\Users\whitn\OneDrive\Documenten\COMPVISION-GRRRRRRRRR\assignment2\part1_image_enhancement\images\image1.jpg');
approx_im = imread('C:\Users\whitn\OneDrive\Documenten\COMPVISION-GRRRRRRRRR\assignment2\part1_image_enhancement\images\image1_saltpepper.jpg');
error = myPSNR(orig_im, approx_im)

%            ====== Question 6.3 ======
orig_im = imread('C:\Users\whitn\OneDrive\Documenten\COMPVISION-GRRRRRRRRR\assignment2\part1_image_enhancement\images\image1.jpg');
approx_im = imread('C:\Users\whitn\OneDrive\Documenten\COMPVISION-GRRRRRRRRR\assignment2\part1_image_enhancement\images\image1_gaussian.jpg');
error = myPSNR(orig_im, approx_im)
