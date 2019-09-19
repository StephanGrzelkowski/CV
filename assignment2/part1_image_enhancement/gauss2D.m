function G = gauss2D( sigma , kernel_size )
    %% solution
    %first calculate the 1D filter:
    G1d = gauss1d(sigma, kernel_size); 
    %take the product of the two: 
    G = G1d' * G1d;
    %normalize again
    G = G ./ sum(G, [], 'all');
end
