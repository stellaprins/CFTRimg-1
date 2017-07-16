function [ imageStruct ] = imgSegment( imageStruct )
%IMGSEGMENT Summary of this function goes here
%   Detailed explanation goes here

image = imread(imageStruct.path);

image = double(image);

gray = mat2gray(image,[min(image(:)) max(image(:))]);

adjusted = imadjust(gray,[],[],0.8);

bw = imbinarize(adjusted);

filled = imfill(bw,'holes');

[labelled, ~] = bwlabel(filled,8);

properties = regionprops(labelled,'BoundingBox'...
						,'MajorAxisLength','MinorAxisLength'); 

for i=1:length(properties)
	
	imageStruct.boundingBox(i,:) = properties(i).BoundingBox;
	
end

imageStruct.cellLength = [properties.MajorAxisLength]';
imageStruct.cellWidth = [properties.MinorAxisLength]';
imageStruct.cellN(1,1) = length(properties);

end




