function [rotatedImage] = myAffine(image, A)
    [M, N] = size(image);
    % calculate X ( insert code for this )
    B = [ 1 1; 1 N; M 1]';
    X = B / A;
    
    % calculate x and y ( insert code for this )
    [x,y] = meshgrid(1:M, 1:N);
    coords = [reshape(x,1,[]);reshape(y,1,[]);ones(1,M*N)];
    c = X * coords;
    XcoordNew = c(1,:);
    YcoordNew = c(2,:);
    
    pixelValue(image, x, y)
    new = arrayfun(@(y,x) pixelValue(image,x,y),XcoordNew,YcoordNew);
    rotatedImage = reshape(new,[M,N]);
    p=1;
    
end