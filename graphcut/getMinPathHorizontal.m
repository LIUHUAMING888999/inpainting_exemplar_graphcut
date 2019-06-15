function [cutarr] = getMinPathHorizontal(ddelta,patchsize, overlap)
%GETMINPATH 此处显示有关此函数的摘要
%    get minimize patch about ddelta in horizontal direction
cutarr = zeros(patchsize, 1);

cutarr(patchsize) = find(ddelta(:, patchsize)==min(ddelta(:, patchsize)), 1, 'first');
% 从右到左，后退找到最小路径
for i=patchsize: -1: 2;
    if cutarr(i) == 1
        temp = [ddelta(1, i-1) ddelta(2, i-1)];
        cutarr(i-1) = find(temp==min(temp), 1, 'first');
    elseif cutarr(i) == overlap
        temp = [ddelta(overlap, i-1) ddelta(overlap-1, i-1)];
        cutarr(i-1) = overlap + 1 - find(temp==min(temp), 1, 'first');
    else
        temp = [ddelta(cutarr(i)-1, i-1) ddelta(cutarr(i), i-1) ddelta(cutarr(i)+1, i-1)];
        cutarr(i-1) = cutarr(i) - 2 + find(temp==min(temp), 1, 'first');
    end
end

end

