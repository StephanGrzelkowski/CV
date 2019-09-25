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
        laplacian = fspecial('laplacian');
        imOut = imfilter(image_smooth, laplacian, 'replicate','conv');

    case 2 
        % Take the LoG of the image
        LoG = fspecial('log', kernel_size, sigma);
        imOut = imfilter(image, LoG, 'replicate', 'conv');

    case 3
        % First create two gauss kernels to smooth the image
        % Then calculate the difference between the smoothed images
        gauss_1 = fspecial('gaussian', kernel_size, sigma)
        gauss_2 = fspecial('gaussian', kernel_size, sigma * 1.6)
        DoG_1 = imfilter(image, gauss_1, 'conv');
        DoG_2 = imfilter(image, gauss_2, 'conv');
        imOut = DoG_1 - DoG_2;
end
end

