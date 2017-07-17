function cellDisplay(imageStruct, boundingBox_idx )
%CELLDISPLAY Summary of this function goes here
%   Detailed explanation goes here

image = imread(imageStruct.redPath);
boundingBox = imageStruct.boundingBox(boundingBox_idx,:);

cropped = boundingBoxToCroppedImage(image,boundingBox);

doubleImage = im2double(cropped);

adjusted = imadjust(doubleImage,[min(doubleImage(:)); max(doubleImage(:))]...
	,[0; 1]);

imshow(adjusted)

end

