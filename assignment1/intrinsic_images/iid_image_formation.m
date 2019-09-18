imOrig = imread('D:\Google accounts\Student account\School\Master AI\Computer Vision 1\Lab assignments\Assignment 1\intrinsic_images\ball.png');
imAlb = imread('D:\Google accounts\Student account\School\Master AI\Computer Vision 1\Lab assignments\Assignment 1\intrinsic_images\ball_albedo.png');
imSha = imread('D:\Google accounts\Student account\School\Master AI\Computer Vision 1\Lab assignments\Assignment 1\intrinsic_images\ball_shading.png');

imRec = double(imSha) .* double(imAlb);

subplot(2, 2, 1), imshow(imOrig)
subplot(2, 2, 2), imshow(imAlb)
subplot(2, 2, 3), imshow(imSha)
subplot(2, 2, 4), imshow(uint16(imRec))
