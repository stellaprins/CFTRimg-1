function [ imageStruct ] = imgFilterUnmasked( imageStruct )
%IMG_FILTER_UNMASKED Removes cells from analysis if binarizing creates an
%cell mask either of all zeros or all ones.
%   Occasionally the binarizing process to create a cell mask either
%   includes every pixel in the cell bounding box or zero pixels.
%   Effectively the cell mask creation process has failed. These cells are
%   excluded from the analysis.

redImage = im2double(imread(imageStruct.redPath));

binning = imageStruct.binning;

cellN = imageStruct.cellN(end);

cellLogical = zeros(cellN,1);

for i=1:cellN
	
	boundBox = imageStruct.boundingBox(i,:);

	cellMask = boundingBoxToCellMask(redImage,boundBox,binning);
	
	cellLogical(i) = sum(cellMask(:)) > 0 & sum(cellMask(:)) < length(cellMask(:));

end

cellN = sum(cellLogical);
newBoundingBox = zeros(cellN,4);

counter=1;
for i=1:length(cellLogical)
	if cellLogical(i) == 1
		newBoundingBox(counter,:)	= imageStruct.boundingBox(i,:);
		counter = counter + 1;
	end
end

imageStruct.boundingBox = newBoundingBox;
imageStruct.cellN(1,end+1) = cellN;


end

