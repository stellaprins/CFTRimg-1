function [ imageStruct ] = imgFilterCellDimensions( imageStruct )
%IMG_FILTER_CELL_DIMENSIONS Remove cells from analysis according to cell
%dimensions
%   Cells are removed if they are
%			* too large
%			* too small
%			* have a large cell perimeter relative to their area
%		This last criterion ensures that selected cells are loosely circular.

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
		
				cellLogical(idx) = cellLength < 300*BINNING ...
											& 50*BINNING < cellWidth ...
											& cellArea/cellPerimeter > 20*BINNING;

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