function [ imageStruct ] = imgFindCellDimensions( imageStruct )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

image = imread(imageStruct.redPath);

counter = 1;
for idx=1:imageStruct.cellN(end)
	
	boundingBox = imageStruct.boundingBox(idx,:);

	cropped = boundingBoxToCroppedImage(image,boundingBox);

	bw = cellBinarize(cropped);

	[labelled, ~] = bwlabel(bw,8);
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

