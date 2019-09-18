%What other components can an image be decomposed other than albedo and
%shading? Give an example and explain your reasoning.

% Camera response function / scale

%If you check the literature, you will see that almost all the intrinsic image
%decomposition datasets are composed of synthetic images. What might be
%the reason for that?

% You have to know the normals and the smoothness of the normals, making
% the assumptions to restrictive in non-trivial cases
OG = imread('ball.png');

A = imread('ball_albedo.png');
S = imread('ball_shading.png');
kd=1;

x = size(A);
I = A;

for row= 1:x(1)
    for column = 1:x(2)
        pix = squeeze( A(row,column,:) );
        el = S(row,column) /150  ;
        pixel = pix*el;
        I(row,column,:) = pixel;
    end
end
subplot(2,2,1);
imshow(OG);

subplot(2,2,2);
imshow(A);
subplot(2,2,3);
imshow(S);
subplot(2,2,4);
imshow(I);



