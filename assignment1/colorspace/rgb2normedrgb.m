function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
[R, G, B] = getColorChannels(input_image);
class(R)
size(R)
absolute_intensity = R + G + B;
r = R / absolute_intensity;
g = G / absolute_intensity;
b = B / absolute_intensity;
output_image = cat(3, r, g, b);
end

