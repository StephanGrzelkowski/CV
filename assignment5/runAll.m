%number of images for creating the dictionary 
n_dict = 10;
%load the dictionary images
[x_dict, y_dict] = loadData('train', n_dict );
%show an example to make sure it worked
figure; 
imshow(x_dict(:,:,:,2)./255)
cell_f = cell(1, n_dict);
cell_d = cell(1, n_dict);
for it = 1: n_dict
   cur_img = single(rgb2gray(x_dict(:,:,:,it)./255));
   %compute sift 
   [cell_f{it},cell_d{it}] = vl_sift(cur_img);
   
end