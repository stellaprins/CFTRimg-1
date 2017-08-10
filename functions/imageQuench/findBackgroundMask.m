function  cellMask  = findBackgroundMask( redImage )
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here

adjusted = imadjust(redImage);

thresh = 0.2*graythresh(adjusted);

Ibw = imbinarize(adjusted,thresh);

se = strel('disk',1);

tmp = Ibw;

for i=1:5
	tmp = imdilate(tmp,se);
end

cellMask = ~tmp;


end

