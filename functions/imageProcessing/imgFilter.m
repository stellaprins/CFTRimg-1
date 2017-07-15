function [ imageStruct ] = imgFilter( imageStruct )
%IMGFILTER Summary of this function goes here
%   Detailed explanation goes here

cellLength	= imageStruct.cellLength;
cellWidth	= imageStruct.cellWidth;
boundingBox = imageStruct.boundingBox;

cellLogical = 100 < cellLength & cellLength < 300 & ...
	80 < cellWidth & cellWidth < 200;

cellN = sum(cellLogical);
newBoundingBox = cell(cellN,1);
newCellWidth = zeros(cellN,1);
newCellLength = zeros(cellN,1);

counter=1;
for i=1:length(cellLogical)
	if cellLogical(i) == 1
		newBoundingBox{counter}	= boundingBox{i};
		newCellWidth(counter)	= cellWidth(i);
		newCellLength(counter)	= cellLength(i);
		counter = counter + 1;
	end
end

imageStruct.boundingBox = newBoundingBox;
imageStruct.cellLength = newCellLength;
imageStruct.cellWidth = newCellWidth;
imageStruct.cellN(2,1) = cellN;

end

