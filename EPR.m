function [EPRa, EPRr]=EPR(reference, distorted)
if(size(reference,3) ==3)
    reference = rgb2gray(reference);
end
if(size(distorted,3)==3)
    distorted = rgb2gray(distorted);
end
[bwRef ,th ] = edge(reference,'canny');
[bwDis]=  edge(distorted,'canny',th);

% 
% figure;imshow(bwRef);
% figure;imshow(bwDis);
add_edge = bwRef&bwDis;
EPRa = sum(add_edge(:))/sum(bwRef(:));

EPRr = sum(add_edge(:))/sum(bwDis(:));


end