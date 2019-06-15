function [out] = cos_distance(x,y)
% ”‡œ“œ‡À∆∂»
%\[\cos (a) = \frac{{\sum {({x_i} \times {y_i})} }}{{\sqrt {\sum {{x_i}^2} }  \times \sqrt {\sum {{y_i}^2} } }}\]
outputArg1 = x(:);
outputArg2 = y(:);
out =sum(outputArg1.*outputArg2)/(sqrt(sum(outputArg1.^2))*sqrt(sum(outputArg2.^2)));
end

