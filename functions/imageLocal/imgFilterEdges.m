function [ imageStruct ] = imgFilterEdges( imageStruct )
%IMG_FILTER_EDGES Removes all cells from processing which sit on the edge
%of the full image.
%		These cells are removed due to the likelihood of them being only
%		partially included within the larger image.

global BINNING EXTRA

boundingBox = imageStruct.boundingBox;

imageDim = 2160*BINNING;

xmin = ceil(boundingBox(:,1)) - EXTRA;
xmax = floor(boundingBox(:,1)) + boundingBox(:,3) + EXTRA;
ymin = ceil(boundingBox(:,2)) - EXTRA;
ymax = floor(boundingBox(:,2)) + boundingBox(:,4) + EXTRA;

cellLogical = xmin > 1 & ymin > 1 & ...
	xmax < imageDim & ymax < imageDim;

cellN = sum(cellLogical);
newBoundingBox = zeros(cellN,4);

counter=1;
for i=1:length(cellLogical)
	if cellLogical(i) == 1
		newBoundingBox(counter,:)	= boundingBox(i,:);
		counter = counter + 1;
	end
end

imageStruct.boundingBox = newBoundingBox;
imageStruct.cellN(1,end+1) = cellN;

end

