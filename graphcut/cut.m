function imout = cut(sample, patchsize, overlap, imout, samplepos, imoutpos)

samplesz = size(sample);
sampledms = length(samplesz);

% copy the nonoverlap region 
imout(imoutpos(1)+overlap:imoutpos(1)+patchsize-1, imoutpos(2)+overlap:imoutpos(2)+patchsize-1, :) =...
    sample(samplepos(1)+overlap:samplepos(1)+patchsize-1, samplepos(2)+overlap:samplepos(2)+patchsize-1, :);

imoutsz = size(imout);
imoutdms = length(imoutsz);

samplet = zeros(patchsize, overlap); %得到重叠区域（上）
imoutt = zeros(patchsize, overlap);  %得到重叠区域（下）
delta = zeros(patchsize, overlap);

if sampledms == 2
    samplet(:, :) = sample(samplepos(1):samplepos(1)+patchsize-1, samplepos(2):samplepos(2)+overlap-1);
else
        t_overlap =sample(samplepos(1):samplepos(1)+patchsize-1, samplepos(2):samplepos(2)+overlap-1, :);
        samplet(:, :) = sum(   t_overlap , 3);
   
end

if imoutdms == 2
    imoutt(:, :) = imout(imoutpos(1):imoutpos(1)+patchsize-1, imoutpos(2):imoutpos(2)+overlap-1);
else
     t_overlap = imout(imoutpos(1):imoutpos(1)+patchsize-1, imoutpos(2):imoutpos(2)+overlap-1, :);
     imoutt(:, :) =  sum( t_overlap,3);
end

delta =abs( samplet- imoutt ); %the difference of overlap

 ddelta =getMinErrorVertical (delta, patchsize,overlap);
 [cutarr] = getMinPathVertical(ddelta,patchsize, overlap);
 

for i=0: 1: patchsize-1;
    imout(imoutpos(1)+i, imoutpos(2)+cutarr(i+1)-1:imoutpos(2)+overlap-1, :) =...
        sample(samplepos(1)+i, samplepos(2)+cutarr(i+1)-1:samplepos(2)+overlap-1, :);
end



samplet = zeros(overlap, patchsize);
imoutt = zeros(overlap, patchsize);
delta = zeros(overlap, patchsize);

if sampledms == 2
    samplet(:, :) = sample(samplepos(1):samplepos(1)+overlap-1, samplepos(2):samplepos(2)+patchsize-1);
else     
        samplet = sum( sample(samplepos(1):samplepos(1)+overlap-1, samplepos(2):samplepos(2)+patchsize-1, :),3);     
end

if imoutdms == 2
    imoutt(:, :) = imout(imoutpos(1):imoutpos(1)+overlap-1, imoutpos(2):imoutpos(2)+patchsize-1);
else    
        imoutt(:, :) =sum( imout(imoutpos(1):imoutpos(1)+overlap-1, imoutpos(2):imoutpos(2)+patchsize-1, :), 3);    
end

delta =abs(samplet - imoutt ) ; 

[ ddelta] = getMinErrorHorizontal(delta,patchsize, overlap);
 [cutarr] = getMinPathHorizontal(ddelta,patchsize, overlap);
 
for i=0: 1: patchsize-1;
    imout(imoutpos(1)+cutarr(i+1)-1:imoutpos(1)+overlap-1, imoutpos(2)+i, :) = ...
        sample(samplepos(1)+cutarr(i+1)-1:samplepos(1)+overlap-1, samplepos(2)+i, :);
end
