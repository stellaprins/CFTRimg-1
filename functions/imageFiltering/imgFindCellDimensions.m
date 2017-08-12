function [ imageStruct ] = imgFindCellDimensions( imageStruct )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

image = im2double(imread(imageStruct.redPath));

counter = 1;
for idx=1:imageStruct.cellN(end)
	
	boundingBox = imageStruct.boundingBox(idx,:);

	cellMask = boundingBoxToCellMask(image,boundingBox);

	[labelled, ~] = bwlabel(cellMask,8);
	properties = regionprops(labelled ...
		,'MinorAxisLength','MajorAxisLength');
	
	if length(properties) == 1
		imageStruct.boundingBox(counter,:) = imageStruct.boundingBox(idx,:);
		imageStruct.cellLength(counter,:) = properties(1).MajorAxisLength;
		imageStruct.cellWidth(counter,:) = properties(1).MinorAxisLength;
		counter = counter + 1;
	end
	
end
	
imageStruct.cellN(1,end+1) = counter - 1;

end


% 
% function [ imageStruct ] = imgFilterCellSize( imageStruct )
% %IMGFILTERCELLSIZE Summary of this function goes here
% %   Detailed explanation goes here
% 
% global BINNING
% 
% cellLength	= imageStruct.cellLength;
% cellWidth	= imageStruct.cellWidth;
% boundingBox = imageStruct.boundingBox;
% 
% cellLogical = 100*BINNING < cellLength & cellLength < 300*BINNING & ...
% 	80*BINNING < cellWidth & cellWidth < 200*BINNING;
% 
% cellN = sum(cellLogical);
% newBoundingBox = zeros(cellN,4);
% newCellWidth = zeros(cellN,1);
% newCellLength = zeros(cellN,1);
% 
% counter=1;
% for i=1:length(cellLogical)
% 	if cellLogical(i) == 1
% 		newBoundingBox(counter,:)	= boundingBox(i,:);
% 		newCellWidth(counter)		= cellWidth(i);
% 		newCellLength(counter)		= cellLength(i);
% 		counter = counter + 1;
% 	end
% end
% 
% imageStruct.boundingBox = newBoundingBox;
% imageStruct.cellLength = newCellLength;
% imageStruct.cellWidth = newCellWidth;
% imageStruct.cellN(1,end+1) = cellN;
% 
% end


