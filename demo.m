%  
clc;close all; clear  ;
path_image   = 'testimages\image\';
path_mask    = 'testimages\mask\';
path_corrupt = 'testimages\corrupt\';
fileFolder=fullfile(path_image);
dirOutput=dir(fullfile(fileFolder,'*.png'));
imglist={dirOutput.name}';
addpath(genpath('vlfeat-0.9.21-bin'));
addpath('image_pyramid');
addpath('tool');
addpath('exemplar');
addpath('graphcut');
global coefficientPara
patchSize= [15,15,9,11,11,9,9,9,5,5,15,23,11];
coefficientPara=[ 0.95,0.1   ];
global ref_num;
ref_num = 5; 
f = fopen('experiment.txt','a+');
fprintf(f,'name,       psnr       ,ssim      ,fsim            ,EPRa      \n' );    
for num=1: size(imglist,1)% size(img_n,2) 
%     num=img_n(x);
    %     imgname =  (strcat( 'testimage2\', imglist{num}, '.png'));
    imgname =[path_image, strtrim( imglist{num,1}) ]
    %     damagedImgname =  (strcat('testimage2\' , imglist{num}, '1.png'));
    damagedImgname = [path_corrupt, strrep(strtrim( imglist{num,1}) ,'.png','1.png')];
    mask = imread([path_mask,  strtrim( strrep( imglist{num,1},'.png','_mask.png'))  ]);
    rate =  sum(sum(mask(:,:,1))) /(size(mask,1)*size(mask,2));
    %
    color = [255 0 0];
    t1=clock;
 
    [ img,orginimg ]   = inpaint_ssim1( imgname, damagedImgname,mask, color, patchSize(num));
%           figure;movie(FILLMOVIE);
%           VIDEOWRITER(FILLMOVIE,'circle.avi')
    t2=clock;
    img = img.*double(mask>0)+orginimg.*double((~mask)>0);
    img = img*255;
    orginimg=orginimg*255;
    t=etime(t2,t1);
    damagedImg = imread(damagedImgname);
%              figure;imshow( uint8(img ));
%             figure;imshow(damagedImg);
    pr = psnr(uint8(img),uint8( orginimg(1:size(img,1),1:size(img,2),:))) ;
    [ ssim_value] = ssim(uint8(img),uint8( orginimg)) ;
    [FSIM_value,fsim_color_value2] =FeatureSIM(uint8(img),uint8( orginimg)) ;
    [EPRa,~ ] = EPR(uint8(orginimg),uint8(img)); 
    name= strtrim( imglist{num,1}) ; name=name(1:end -4);
    imwrite(uint8(img),['testimages\result\' name '-patch_size-' num2str(patchSize(num)) '-rate-' num2str(rate) '-t-' num2str(t)  '_psnr_'...
        num2str(pr) '_ssim_' num2str(ssim_value) '-fsim-' num2str(fsim_color_value2) '-EPRa-' num2str(EPRa) '-.png']);
     fprintf('name:%s---->psnr:%f,ssim:%f,fsim:%f,EPRa:%f\n',imglist{num,1},pr,ssim_value,fsim_color_value2,EPRa);    
      fprintf(f,'name:%s---->psnr:%f,ssim:%f,fsim:%f,EPRa:%f\n',imglist{num,1},pr,ssim_value,fsim_color_value2,EPRa);    
end
fclose(f);
fprintf('inpainting completed\n');
fprintf('inpainted results can be found in the path "testimages/result/"\n');
fprintf('the data is saved in the experiment.txt \n');