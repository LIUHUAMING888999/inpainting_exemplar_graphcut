function [ x_n ] = genMyPyramid( x, nlevel )
%
x_n= cell(1,nlevel);
x_n{1} = x;
for i=2: nlevel
       x_n{i}= vl_imdown(x_n{i-1}); 
end

% for i = 1 : nlevel
%     figure;imshow(uint8(x_n{i})*255);
% end

end

