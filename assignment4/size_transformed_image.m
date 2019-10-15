function [W, H, min_w, min_h] = size_transformed_image(N, M, m, t)
% This function returns what the new size W x H should become when an original
% image of dimensions N x M is transformed with transformation parameters m
% (== m1, m2, m3, m4) and t (== t1, t2). min_w and min_h ('minimum width' and 'minimum height') return the maximum
% magnitudes of negative oordinate values. These are needed to calculate how much new coordinates need to be shifted to circumvent problems that occur with
% negative coordinates.
    p1 = ceil(m * [1;1] + t');
    p2 = ceil(m * [N;1] + t');
    p3 = ceil(m * [1;M] + t');
    p4 = ceil(m * [N;M] + t');
    
    min_w = min([p1(2),p2(2),p3(2),p4(2)]); 
    if min_w > 1
        min_w = 0;
    else
        min_w = abs(min_w) + 1;
    end
    
    min_h = min([p1(1),p2(1),p3(1),p4(1)]);
    if min_h > 1
        min_h = 0;
    else
        min_h = abs(min_h) + 1;
    end
    
    W = abs(p2(2) - p3(2));
    H = abs(p1(1) - p4(1));
end