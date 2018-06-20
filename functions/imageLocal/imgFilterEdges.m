function [ imageStruct ] = imgFilterEdges( imageStruct )
%IMG_FILTER_EDGES Removes all cells from processing which sit on the edge
%of the full image.
%		These cells are removed due to the likelihood of them being only
%		partially included within the larger image.

binning = imageStruct.binning;
extra = ceil(20*binning);

boundingBox = imageStruct.boundingBox;

dummyImage	= imread(imageStruct.redPath);
imageDimX	= size(dummyImage,2);
imageDimY		= size(dummyImage,1);

xmin = ceil(boundingBox(:,1)) - extra;
xmax = floor(boundingBox(:,1)) + boundingBox(:,3) + extra;
ymin = ceil(boundingBox(:,2)) - extra;
ymax = floor(boundingBox(:,2)) + boundingBox(:,4) + extra;

cellLogical = xmin > 1 & ymin > 1 & ...
	xmax < imageDimX & ymax < imageDimY;

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

