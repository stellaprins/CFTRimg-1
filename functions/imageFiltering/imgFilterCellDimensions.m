function [ imageStruct ] = imgFilterCellDimensions( imageStruct )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

image = im2double(imread(imageStruct.redPath));

cellLogical = zeros(imageStruct.cellN(end),1);

for idx=1:imageStruct.cellN(end)
	
	boundingBox = imageStruct.boundingBox(idx,:);

	cellMask = boundingBoxToCellMask(image,boundingBox);

	[labelled, ~] = bwlabel(cellMask,8);
	properties = regionprops(labelled ...
		,'MinorAxisLength','MajorAxisLength','Area','Perimeter');
	
	if length(properties) == 1
		cellLength = properties(1).MajorAxisLength;
		cellWidth = properties(1).MinorAxisLength;
		
		cellArea = properties(1).Area;
		cellPerimeter = properties(1).Perimeter;
		
		cellLogical(idx) = 100*BINNING < cellLength ...
											& cellLength < 300*BINNING ...
											& 80*BINNING < cellWidth ...
											& cellWidth < 250*BINNING ...
											& cellArea/cellPerimeter > 20;

	end

end

cellN = sum(cellLogical);
newBoundingBox = zeros(cellN,4);

counter = 1;
for idx=1:imageStruct.cellN(end)
	
	boundingBox = imageStruct.boundingBox(idx,:);
	
	if cellLogical(idx) == 1
		
		newBoundingBox(counter,:)	= boundingBox;
		counter = counter + 1;
		
	end

end
	
imageStruct.boundingBox = newBoundingBox;
imageStruct.cellN(1,end+1) = counter - 1;

end