function [ imageStruct ] = imgFilterUnmasked( imageStruct )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

redImage = im2double(imread(imageStruct.redPath));

cellN = imageStruct.cellN(end);
% redBackground = imageStruct.redBackground;

cellLogical = zeros(cellN,1);

for i=1:cellN
	
	boundBox = imageStruct.boundingBox(i,:);

	cellMask = boundingBoxToCellMask(redImage,boundBox);
	
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

