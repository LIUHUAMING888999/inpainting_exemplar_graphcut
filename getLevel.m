function [ L ] = getLevel( input ,patchsize) 
L = floor(log2(min(size(input,1),size(input,2)))) - ceil(log2(min(  patchsize)));
end

