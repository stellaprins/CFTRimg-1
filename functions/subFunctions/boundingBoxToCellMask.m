function [ cellMask ] = boundingBoxToCellMask( fullImage, boundingBox )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
	
global EXTRA

image = imadjust(fullImage);

xmin = ceil(boundingBox(1)) - EXTRA;
xmax = floor(boundingBox(1)) + boundingBox(3) + EXTRA;
ymin = ceil(boundingBox(2)) - EXTRA;
ymax = floor(boundingBox(2)) + boundingBox(4) + EXTRA;

croppedImage = image(ymin:ymax,xmin:xmax);

cellMask = cellBinarize(croppedImage);


end

