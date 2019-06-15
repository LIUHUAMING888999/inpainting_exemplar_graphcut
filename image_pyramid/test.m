close all
clear
imga = im2double(imread('apple1.jpg'));  

 x1 = impyramid(imga,'reduce');
 
% level = 5;
% x = genPyr(imga,'gauss',level); % the Laplacian pyramid 
% 
% figure;
% subplot 221;imshow(x{1});
% subplot 222;imshow(x{2});
% subplot 223;imshow(x{3});
% subplot 224;imshow(x{4});