function [ cells ] = imgSegment( image )
%IMGSEGMENT Summary of this function goes here
%   Detailed explanation goes here

gray = mat2gray(image,[min(image(:)) max(image(:))]);

adjusted = imadjust(gray,[],[],0.8);

bw = imbinarize(adjusted);

filled = imfill(bw,'holes');

[labelled, ~] = bwlabel(filled,8);

properties = regionprops(labelled, 'Image','BoundingBox'...
						,'MajorAxisLength','MinorAxisLength'); 

					
cellLength = [properties.MajorAxisLength]';
cellWidth = [properties.MinorAxisLength]';

cellsLogical = 100 < cellLength  & cellLength < 300 & ...
	80 < cellWidth  & cellWidth < 200;

sum(cellsLogical);

counter=1;
for i=1:length(cellsLogical)
	if cellsLogical(i) ==1
		cells(counter) = properties(i);
		counter = counter + 1;
	end
end

