function cellDisplay(imageStruct, colorStr, boundingBox_idx )
%CELLDISPLAY Summary of this function goes here
%   Detailed explanation goes here

if strcmp(colorStr,'red') || strcmp(colorStr,'bw')
	image = imread(imageStruct.redPath);
elseif  strcmp(colorStr,'yel')
	image = imread(imageStruct.yelPath);
else
	disp('Please enter "red", "yel" or "bw".')
	image = [];
end

boundingBox = imageStruct.boundingBox(boundingBox_idx,:);

cropped = boundingBoxToCroppedImage(image,boundingBox);

if strcmp(colorStr,'bw')
	
	croppedAdj = cropped - imageStruct.redBackground;
	
	cellMask = cellBinarize(croppedAdj);
	
	imshow(cellMask,[],'InitialMagnification','fit')
	
else

	imshow(cropped,[],'InitialMagnification','fit')
	
end

end

