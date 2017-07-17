function [ imageStruct ] = imgSegment( imageStruct )
%IMGSEGMENT Summary of this function goes here
%   Detailed explanation goes here

image = imread(imageStruct.path);

image = double(image);

intMin = min(image(:));
intMax = max(image(:));
range = intMax - intMin;
gray = mat2gray(image,[(intMin+0.25*range) (intMin+range)]);

bw = imbinarize(gray);

filled = imfill(bw,'holes');

[labelled, ~] = bwlabel(filled,8);
properties = regionprops(labelled,'BoundingBox','Area');

counter = 1;
for i=1:length(properties)
	
	if properties(i).Area > 10
		imageStruct.boundingBox(counter,:) = properties(i).BoundingBox;
		counter = counter + 1;
	end
	
end

imageStruct.cellN(1,1) = counter - 1;

end




