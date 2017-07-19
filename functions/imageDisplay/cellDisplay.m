function cellDisplay(imageStruct, colorStr, boundingBox_idx )
%CELLDISPLAY Summary of this function goes here
%   Detailed explanation goes here

if strcmp(colorStr,'red')
	image = imread(imageStruct.redPath);
elseif  strcmp(colorStr,'yel')
	image = imread(imageStruct.yelPath);
else
	disp('Please enter "red" or "yel".')
	image = [];
end

boundingBox = imageStruct.boundingBox(boundingBox_idx,:);

cropped = boundingBoxToCroppedImage(image,boundingBox);

imshow(cropped,[],'InitialMagnification','fit')

end

