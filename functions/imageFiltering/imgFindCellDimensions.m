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

