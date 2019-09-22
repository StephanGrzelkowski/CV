function [ imOut ] = denoise( image, kernel_type, varargin)
varargin = cell2mat(varargin); % Ensure the input are numeric and not cell array type
switch kernel_type
    case 'box'
        imOut = imboxfilt(image, varargin);  
    case 'median'
        imOut = medfilt2(image,[varargin varargin]);
    case 'gaussian'
        kernel = gauss2D(varargin(1), varargin(2)); % assume that the 1st argument is sigma, the 2nd one the kernel size
        %imOut = % convolution formula
end
end
