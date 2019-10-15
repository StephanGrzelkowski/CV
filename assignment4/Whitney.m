function [W, H, min_w, min_h] = Whitney(N, M, m, t)
    p1 = ceil(m * [1;1] + t');
    p2 = ceil(m * [N;1] + t');
    p3 = ceil(m * [1;M] + t');
    p4 = ceil(m * [N;M] + t');
    
    min_w = min([p1(2),p2(2),p3(2),p4(2)]); 
    if min_w > 1
        min_w = 0
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