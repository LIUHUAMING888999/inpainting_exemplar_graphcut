function [cutarr] = getMinPathVertical(ddelta,patchsize, overlap)
%GETMINPATH 此处显示有关此函数的摘要
%    %    get minimize patch about ddelta in vertical direction
% 参考论文：image quilting for texture synthesis and transfer.
cutarr = zeros(patchsize, 1);
cutarr(patchsize) = find(ddelta(patchsize, :)==min(ddelta(patchsize, :)), 1, 'first');

% 从下到上，后退到最小路径
for i=patchsize: -1: 2;
    if cutarr(i, 1) == 1
        temp = [ddelta(i-1, 1) ddelta(i-1, 2)];
        cutarr(i-1) = find(temp==min(temp), 1, 'first');
    elseif cutarr(i) == overlap
        temp = [ddelta(i-1, overlap) ddelta(i-1, overlap-1)];
        cutarr(i-1) = overlap + 1 - find(temp==min(temp), 1, 'first');
    else
        temp = [ddelta(i-1, cutarr(i)-1) ddelta(i-1, cutarr(i)) ddelta(i-1, cutarr(i)+1)];
        cutarr(i-1) = cutarr(i) - 2 + find(temp==min(temp), 1, 'first');
    end
end

end

