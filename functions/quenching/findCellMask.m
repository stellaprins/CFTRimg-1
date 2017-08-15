function  cellMask  = findCellMask( redImage )
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here

adjusted = imadjust(redImage);

thresh = 0.8*graythresh(adjusted);

Ibw = imbinarize(adjusted,thresh);

se = strel('disk',1);

tmp = Ibw;

for i=1:4
	tmp = imdilate(tmp,se);
end

cellMask = tmp;


end

