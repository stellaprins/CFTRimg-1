function [ imageStruct ] = imgFilterEdges( imageStruct )
%IMGFILTEREDGES Summary of this function goes here
%   Detailed explanation goes here

global BINNING

cellLength	= imageStruct.cellLength;
cellWidth	= imageStruct.cellWidth;
boundingBox = imageStruct.boundingBox;

imageDim = 2160*BINNING;

xmin = ceil(boundingBox(:,1));
xmax = floor(boundingBox(:,1)) + boundingBox(:,3);
ymin = ceil(boundingBox(:,2));
ymax = floor(boundingBox(:,2)) + boundingBox(:,4);

cellLogical = xmin ~= 1 & ymin ~= 1 & ...
	xmax ~= imageDim & ymax ~= imageDim;

cellN = sum(cellLogical);
newBoundingBox = zeros(cellN,4);
newCellWidth = zeros(cellN,1);
newCellLength = zeros(cellN,1);

counter=1;
for i=1:length(cellLogical)
	if cellLogical(i) == 1
		newBoundingBox(counter,:)	= boundingBox(i,:);
		newCellWidth(counter)	= cellWidth(i);
		newCellLength(counter)	= cellLength(i);
		counter = counter + 1;
	end
end

imageStruct.boundingBox = newBoundingBox;
imageStruct.cellLength = newCellLength;
imageStruct.cellWidth = newCellWidth;
imageStruct.cellN(1,3) = cellN;

end

