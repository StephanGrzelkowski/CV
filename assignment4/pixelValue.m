function color = pixelValue(image, x, y)
% pixel value at real coordinates
% You shouldnt enter negative numbers thats just stupid
s = size(image);
if [x,y] < [s(1),s(2)] & [x,y] >= [1,1]
    color = image(round(x),round(y));
else
    if x < 1
        newx = 1;
    else
        newx = s(1);
    end
    if y < 1
        newy= 1;
    else
        newy = s(2);
    end
    
    color = single(0);
end