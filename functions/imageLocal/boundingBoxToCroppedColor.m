function [ croppedImage ] = boundingBoxToCroppedColor( fullImage ...
	, boundingBox , binning )
%BOUNDING_BOX_TO_CROPPED_COLOR
	
extra = 20*binning;

xmin = ceil(boundingBox(1)) - extra;
xmax = floor(boundingBox(1)) + boundingBox(3) + extra;
ymin = ceil(boundingBox(2)) - extra;
ymax = floor(boundingBox(2)) + boundingBox(4) + extra;

croppedImage = fullImage(ymin:ymax,xmin:xmax,:);


end

