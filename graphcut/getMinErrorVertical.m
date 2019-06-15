function [ ddelta] = getMinErrorVertical(delta, patchsize, overlap)
%GETMINERRORVALUE �˴���ʾ�йش˺�����ժҪ
%     �ڴ�ֱ��������·�����ۼ�ֵ��
 ddelta = zeros(patchsize, overlap);
ddelta(1, :) = delta(1, :);

for i=2: 1: patchsize;
    for j=1: 1: overlap;
        if j == 1
            ddelta(i, 1) = delta(i, 1) + min([delta(i-1, 1) delta(i-1, 2)]);
        elseif j == overlap
            ddelta(i, overlap) = delta(i, overlap) + min([delta(i-1, overlap-1) delta(i-1, overlap)]);
        else
            ddelta(i, j) = delta(i, j) + min([delta(i-1, j-1) delta(i-1, j) delta(i-1, j+1)]);
        end
    end
end

end

