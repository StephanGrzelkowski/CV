function [W, H] = Whitney(N, M, m, t)
    p1 = ceil(m * [1;1] + t');
    p2 = ceil(m * [N;1] + t');
    p3 = ceil(m * [1;M] + t');
    p4 = ceil(m * [N;M] + t');
    
    W = abs(p2(2) - p3(2));
    H = abs(p1(1) - p4(1));
    test = 2;
end