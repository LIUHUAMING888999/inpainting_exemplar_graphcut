function [ g] = mygradient( img )
% 
[fx,fy] = gradient(img); 
g = abs( fx) + abs(fy );

end

