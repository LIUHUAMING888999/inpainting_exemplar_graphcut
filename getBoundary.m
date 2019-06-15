function [B_out,B_in] = getBoundary(toFill)
%GETBOUNDARY 此处显示有关此函数的摘要
%   此处显示详细说明 
se = [ 0,1,0;1,1,1;0,1,0];
a = imerode(toFill, se);

b = imdilate(toFill,se);
B_out = b- toFill;

B_in = toFill- a;
B_in=logical(B_in);
B_out=logical(B_out);

end

