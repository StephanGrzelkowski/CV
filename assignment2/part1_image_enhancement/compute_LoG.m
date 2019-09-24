function imOut = compute_LoG(image, LOG_type)
image = double(image);
sigma = 0.5;
kernel_size = 5;
switch LOG_type
    case 1
        % Smooth the image with a Gaussian kernel
        % Then apply the Laplacian to the smoothed image
        gauss = fspecial('gaussian', kernel_size, sigma);
        image_smooth = imfilter(image, gauss, 'replicate', 'same');
        laplacian = fspecial('laplacian', 0.5);
        imOut = imfilter(image_smooth, laplacian, 'replicate', 'same');

    case 2 
        % Take the LoG of the image
        LoG = fspecial('log', kernel_size, sigma);
        imOut = imfilter(image, LoG, 'replicate', 'same');

    case 3
        % First create two gauss kernels to smooth the image
        % Then calculate the difference between the smoothed images
        sigma_1 = 0.4;
        sigma_2 = 0.6;
        gauss_1 = fspecial('gaussian', kernel_size, sigma_1);
        gauss_2 = fspecial('gaussian', kernel_size, sigma_2);
        DoG_1 = imfilter(image, gauss_1, 'replicate', 'same');
        DoG_2 = imfilter(image, gauss_2, 'replicate', 'same');
        imOut = DoG_1 - DoG_2;
end
end

