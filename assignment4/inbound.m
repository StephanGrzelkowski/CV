function a = inbound(N, M, new_coords)
    a = false;
    if new_coords(1) > 1 & new_coords(1) <= N;
        if new_coords(2) > 1 & new_coords(2) <= M;
            a = true;
        end        
    end
end