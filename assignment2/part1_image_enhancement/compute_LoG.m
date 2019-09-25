function imOut = compute_LoG(image, LOG_type)
image = im2double(image);
sigma = 0.5;
kernel_size = 5;
switch LOG_type
    case 1
        % Smooth the image with a Gaussian kernel
        % Then apply the Laplacian to the smoothed image
        gauss = fspecial('gaussian', kernel_size, sigma);
        image_smooth = imfilter(image, gauss, 'replicate', 'conv');
        laplacian = fspecial('laplacian', 0);
        imOut = imfilter(image_smooth, laplacian, 'replicate','conv');

    case 2 
        % Take the LoG of the image
        LoG = fspecial('log', kernel_size, sigma);
        imOut = imfilter(image, LoG, 'replicate', 'conv');

    case 3
        % First create two gauss kernels take the DoG and then filter the
        % image.
        sigma_1 = 0.5;
        ratio = 5;
        gauss_1 = fspecial('gaussian', kernel_size, sigma_1);
        gauss_2 = fspecial('gaussian', kernel_size, sigma_1 * ratio);
        dog = gauss_2 - gauss_1;
        imOut = imfilter(image, dog, 'conv');
        
end
end

