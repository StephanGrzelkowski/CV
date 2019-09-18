imOrig = imread('D:\Google accounts\Student account\School\Master AI\Computer Vision 1\Lab assignments\Assignment 1\intrinsic_images\ball.png');
imAlb = imread('D:\Google accounts\Student account\School\Master AI\Computer Vision 1\Lab assignments\Assignment 1\intrinsic_images\ball_albedo.png');
imSha = imread('D:\Google accounts\Student account\School\Master AI\Computer Vision 1\Lab assignments\Assignment 1\intrinsic_images\ball_shading.png');

newAlb = imAlb;

% Replace every pixel in the albedo that contains the true material color
% with pure green.
for i = 1:size(imAlb, 1)
    for j = 1:size(imAlb,2)
        color = squeeze(imAlb(i,j,:));
        if color == [184, 141, 108]'
            newAlb(i,j,:) = [0, 255, 0];
        end
    end
end

imRecolored = double(imSha) .* double(newAlb);

subplot(1, 2, 1), imshow(imOrig)
subplot(1, 2, 2), imshow(uint16(imRecolored))