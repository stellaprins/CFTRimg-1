function cellDisplay(imageStruct, boundingBox_idx )
%CELLDISPLAY Summary of this function goes here
%   Detailed explanation goes here

image = imread(imageStruct.redPath);
boundingBox = imageStruct.boundingBox(boundingBox_idx,:);

xmin = ceil(boundingBox(1));
xmax = floor(boundingBox(1)) + boundingBox(3);
ymin = ceil(boundingBox(2));
ymax = floor(boundingBox(2)) + boundingBox(4);

cropped = image(ymin:ymax,xmin:xmax);

doubleImage = im2double(cropped);

adjusted = imadjust(doubleImage,[min(doubleImage(:)); max(doubleImage(:))]...
	,[0; 1]);

imshow(adjusted)

end

