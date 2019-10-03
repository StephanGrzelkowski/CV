function [matches, scores, f1, f2] = keypoint_matching(img1, img2)


%do sift n each image
[f1,d1] = vl_sift(img1);
[f2,d2] = vl_sift(img2);

%keypoint matching
[matches, scores] = vl_ubcmatch(d1, d2);

end