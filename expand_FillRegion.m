function [ fillRegion2 ] = expand_FillRegion( fillRegion1 ,r )
s = strel('square',r);
fillRegion2 = imdilate(fillRegion1,s);

end

