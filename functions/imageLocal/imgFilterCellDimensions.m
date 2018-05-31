function [ imageStruct ] = imgFilterCellDimensions( imageStruct )
%IMG_FILTER_CELL_DIMENSIONS Remove cells from analysis according to cell
%dimensions
%   Segmented components are removed if they have
%			* too large an area
%			* too long a length
%			* a large cell perimeter relative to their area
%		This last criterion ensures that selected cells are loosely circular.

global BINNING

image = im2double(imread(imageStruct.redPath));

cellLogical = zeros(imageStruct.cellN(end),1);

for idx=1:imageStruct.cellN(end)
	
	boundingBox = imageStruct.boundingBox(idx,:);

	cellMask = boundingBoxToCellMask(image,boundingBox);

	[labelled, ~] = bwlabel(cellMask,8);
	properties = regionprops(labelled,'Area','Perimeter','MajorAxisLength');
	
	if length(properties) == 1
		
		perimeterMask = cellMask;
		perimeterMask(:) = 0;
		perimeterMask(:,1) = 1;
		perimeterMask(:,end) = 1;
		perimeterMask(1,:) = 1;
		perimeterMask(end,:) = 1;
		edgeMask = cellMask & perimeterMask;
		
		edgeProportion = sum(edgeMask(:)) / sum(perimeterMask(:));
		cellLength = properties(1).MajorAxisLength;
		cellArea = properties(1).Area;
		cellPerimeter = properties(1).Perimeter;
		
		
				cellLogical(idx) = cellArea/cellPerimeter > 25*BINNING...
											& cellLength < 300*BINNING...
											& cellArea < 40000*BINNING*BINNING...
											& edgeProportion < 0.3;

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