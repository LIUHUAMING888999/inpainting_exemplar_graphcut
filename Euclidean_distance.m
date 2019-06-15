function [dis ] = Euclidean_distance(a,b)
%ECLI 此处显示有关此函数的摘要
%   此处显示详细说明
dis = sqrt( sum((a(:)-b(:)).^2) );
end

