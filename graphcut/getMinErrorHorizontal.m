function [ ddelta] = getMinErrorHorizontal(delta,patchsize, overlap)
%GETMINERRORVALUE 此处显示有关此函数的摘要
%   在水平方上找路径的累计值。
 ddelta = zeros(overlap, patchsize);

ddelta(:, 1) = delta(:, 1);

for i=2: 1: patchsize;
    for j=1: 1: overlap;
        if j == 1
            ddelta(1, i) = delta(1, i) + min([delta(1, i-1) delta(2, i-1)]);
        elseif j == overlap
            ddelta(overlap, i) = delta(overlap, i) + min([delta(overlap-1, i-1) delta(overlap, i-1)]);
        else
            ddelta(j, i) = delta(j, i) + min([delta(j-1, i-1) delta(j, i-1) delta(j+1, i-1)]);
        end
    end
end
end

