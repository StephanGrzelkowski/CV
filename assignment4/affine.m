function transform_img = affine(img, best_t)
    [N,M] = size(img);
    m = best_t(1:2,1:2);
    t = best_t(3, 1:2);
    [trans_N, trans_M] = Whitney(N, M, m, t);
    
    transform_img = zeros(800, 1000);
    for i = 1:N
        for j = 1:M
            new_coords = round(m * [i;j] + t');
%             if inbound(N, M, new_coords);
                transform_img(new_coords(1),new_coords(2)) = img(i, j);
%             end
        end
    end
end