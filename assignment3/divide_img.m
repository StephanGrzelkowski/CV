function BLOCKS = divide_img(im,block_size)
    s = size(im);
    remx =  mod(s(1),block_size);
    remy =  mod(s(2),block_size);
    newIm = padarray(im,[remx,remy]);
    newS = size(newIm)
    BLOCKS = zeros(15,15,3);
    for i = 0:newS(1)/block_size -1
        startx = 1+i*block_size;
        endx = block_size+i*block_size;
        starty = 1+i*block_size;
        endy = block_size+i*block_size;
        block = newIm(startx:endx,starty:endy,:);
        size(block)
        BLOCKS = cat(4,BLOCKS,block);
    end
end