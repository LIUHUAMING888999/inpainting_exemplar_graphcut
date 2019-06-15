function [  multi_D_n, nLayerNumber  ] = multi_resolution_Dataterm(  img, fillRegion,  patchSize )
%MULTI_RESOLUTION_DATATERM Summary of this function goes here
%  img :  original image
% fillImg:damaged image by color
%fillRegion: mask
% ndx : index in the image

nLayerNumber = getLevel(fillRegion,patchSize)   ;            %

img_n=cell(1,nLayerNumber);
fillRegion_n=cell(1,nLayerNumber);

img_n{1}=img; 
fillRegion_n{1}=fillRegion;
% decompone image by factor 2
for i=2: nLayerNumber
%         img_n{i}= gaussian_smooth(vl_imdown(img_n{i-1}), 3,3,2);       %gaussian filter, delete noise 
         img_n{i}= vl_imdown(img_n{i-1});
        fillRegion_n{i}=vl_imdown(fillRegion_n{i-1});
end
 [D_n] = computerDtern(img_n, fillRegion_n , nLayerNumber);
 

for i =  nLayerNumber :-1:2
    
    
    [height,width] = size(D_n{i-1});
    x = vl_imup(D_n{i});
    [height2,width2] = size(x);
    r1 = height - height2; 
    c1 = width - width2;
    if r1>0 ||c1>0
    D_n{i-1} = D_n{i-1}  + padarray(x, [r1,c1] ,'replicate','post');
    else
           D_n{i-1} = D_n{i-1}  +  x;
    end
end
multi_D_n= D_n{1} ;
end

function [D_n] = computerDtern(img_n, fillRegion_n , nLayerNumber)
D_n=cell(1,nLayerNumber);
alpha_n = cell(1,nLayerNumber);
for i = 1 : nLayerNumber
 [Ix(:,:,3), Iy(:,:,3)] = gradient(img_n{i}(:,:,3));
    [Ix(:,:,2), Iy(:,:,2)] = gradient(img_n{i}(:,:,2));
    [Ix(:,:,1), Iy(:,:,1)] = gradient(img_n{i}(:,:,1));
    Ix = sum(Ix,3)/(3*1); Iy = sum(Iy,3)/(3*1);
    temp = Ix; Ix = -Iy; Iy = temp;  % Rotate gradient 90 degrees
    sz = [size(img_n{i},1),size(img_n{i},2)];
    D = repmat(-.1,sz);
    fillRegionD= double(fillRegion_n{i});
    dR = find(conv2(fillRegionD,[1,1,1;1,-8,1;1,1,1],'same')>0);
    [Nx,Ny] = gradient(double(~fillRegion_n{i})); %
    N = [Nx(dR(:)) Ny(dR(:))];
    N = normr(N);
    N(~isfinite(N))=0; % handle NaN and Inf
%     N_n{i}=N;
    D(dR) = abs(Ix(dR).*N(:,1)+Iy(dR).*N(:,2)) + 0.001;
    
    alpha_n{i} =sum(1: i)/sum(1:nLayerNumber);
    D_n{i} = D * alpha_n{i};
    Ix=[];
    Iy=[];
    D=[];
 
    Nx=[];
    Ny=[];
    
end
end