function [ cellMask ] = boundingBoxToCellMask( fullImage, boundingBox...
	,binning)
%BOUNDING_BOX_TO_CELL_MASK

extra = ceil(20*binning);

image = imadjust(fullImage);

xmin = ceil(boundingBox(1)) - extra;
xmax = floor(boundingBox(1)) + boundingBox(3) + extra;
ymin = ceil(boundingBox(2)) - extra;
ymax = floor(boundingBox(2)) + boundingBox(4) + extra;

croppedImage = image(ymin:ymax,xmin:xmax);

cellMask = cellBinarize(croppedImage,binning);


end

