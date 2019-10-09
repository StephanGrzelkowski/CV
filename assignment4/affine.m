function transform_img = affine(img, best_t)
    [N,M] = size(img);
    m = best_t(1:2,1:2);
    t = best_t(3, 1:2);
    [W, H, min_w, min_h] = Whitney(N, M, m, t);
    
    transform_img = zeros(H, W);
    
    for i = 1:N
        for j = 1:M
            new_coords = round(m * [i;j] + t');
            a = new_coords(1) + min_h;
            b = new_coords(2) + min_w;
            transform_img(a, b) = img(i, j);
        end
    end
end