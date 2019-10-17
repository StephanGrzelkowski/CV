function [f, d] = siftOptions(cur_image, opt_gray, opt_dense)
%this function is a shortcut to do the sift operation with the specified
%options
cur_image = single(cur_image);
%gray or rgb
switch opt_gray
    case 'rgb'
    [f,d] = multichannelSIFT(cur_image, opt_dense);
    case 'oppo'
    cur_image = rgb2opponent(cur_image);
    [f, d] = multichannelSIFT(cur_image, opt_dense);
    case 'gray'
    cur_image = rgb2gray(cur_image);
    [f, d] = siftDense(cur_image, opt_dense);
    otherwise
        error('opt_gray not recognized. Should be "gray" or "rgb"')
end
end

function [f, d] = multichannelSIFT(image, opt_dense)
%this function computes the sift descriptors for each channel and returns
%concatenated features

%preappend
f = [];
d = [];
for it = 1 : size(image, 3)
    %carry out sift
    [fc, dc] = siftDense(image(:,:,it), opt_dense);
    f = cat(2, f, fc);
    d = cat(2, d, dc);
end

end


function [f, d] = siftDense(cur_image, opt_dense)
switch opt_dense
    case 'dense'
        %do smoothing first
        cur_image = vl_imsmooth(cur_image, 1);
        %do sift
        [f, d] = vl_dsift(cur_image, 'fast');
    case 'keypoint'
        %do regular sift
        [f, d] = vl_sift(cur_image(:,:,it));
    otherwise
        error('Not recognized sift option. Should be "dense" or "keypoint"')
end
end