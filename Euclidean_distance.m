function [dis ] = Euclidean_distance(a,b)
%ECLI �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
dis = sqrt( sum((a(:)-b(:)).^2) );
end

