function [ croppedImage ] = boundingBoxToCroppedColor( fullImage, boundingBox )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
	
global EXTRA

xmin = ceil(boundingBox(1)) - EXTRA;
xmax = floor(boundingBox(1)) + boundingBox(3) + EXTRA;
ymin = ceil(boundingBox(2)) - EXTRA;
ymax = floor(boundingBox(2)) + boundingBox(4) + EXTRA;

croppedImage = fullImage(ymin:ymax,xmin:xmax,:);


end

