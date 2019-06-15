function [B_out,B_in] = getBoundary(toFill)
%GETBOUNDARY �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵�� 
se = [ 0,1,0;1,1,1;0,1,0];
a = imerode(toFill, se);

b = imdilate(toFill,se);
B_out = b- toFill;

B_in = toFill- a;
B_in=logical(B_in);
B_out=logical(B_out);

end

