function G = gauss1D( sigma , kernel_size )
if mod(kernel_size, 2) == 0
    error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
end
%% solution
%get the x space
x = -floor(kernel_size / 2) : 1 : floor(kernel_size /2);
%calculate the gaussian filter
G = 1 / (sigma * sqrt(2)) .* exp( (-x.^2) ./ (2*sigma^2));
%normalize G = 1
G = G ./ sum(G, 'all'); 
end
