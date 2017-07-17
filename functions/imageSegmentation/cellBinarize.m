function [ imageStruct ] = cellBinarize( imageStruct )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

global BINNING EXTRA

image = imread(imageStruct.path);

counter = 1;
for idx=1:imageStruct.cellN(end)
	
	boundingBox = imageStruct.boundingBox(idx,:);

	xmin = ceil(boundingBox(1)) - EXTRA;
	xmax = floor(boundingBox(1)) + boundingBox(3) + EXTRA;
	ymin = ceil(boundingBox(2)) - EXTRA;
	ymax = floor(boundingBox(2)) + boundingBox(4) + EXTRA;

	cropped = image(ymin:ymax,xmin:xmax);

	bw = imbinarize(cropped);

	seErode = strel('disk',floor(5*BINNING));
	seDilate = strel('disk',floor(10*BINNING));
	eroded = imerode(bw,seErode);
	% cleared = imclearborder(eroded,8);
	dilated = imdilate(eroded,seDilate);

	% imshow(dilated,[])

	[labelled, ~] = bwlabel(dilated,8);
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

