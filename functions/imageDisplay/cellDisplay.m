function cellDisplay(imageStruct, colorStr, boundingBox_idx )
%CELLDISPLAY Summary of this function goes here
%   Detailed explanation goes here

if strcmp(colorStr,'red')
	image = imadjust(im2double(imread(imageStruct.redPath)));
	[imX,map] = gray2ind(image,256);
	redMap = [map(:,1),zeros(256,1),zeros(256,1)];
	image = ind2rgb(imX,redMap);
elseif  strcmp(colorStr,'yel')
	image = imadjust(im2double(imread(imageStruct.yelPath)));
	[imX,map] = gray2ind(image,256);
	yelMap = [map(:,1),map(:,1),zeros(256,1)];
	image = ind2rgb(imX,yelMap);
elseif strcmp(colorStr,'bw')
	image = im2double(imread(imageStruct.redPath));
elseif strcmp(colorStr,'overlay')
	image = imadjust(im2double(imread(imageStruct.yelPath)));
	[imX,map] = gray2ind(image,256);
	yelMap = [map(:,1),map(:,1),zeros(256,1)];
	image = ind2rgb(imX,yelMap);
	redImage = im2double(imread(imageStruct.redPath));
else
	disp('Please enter "red", "yel" or "bw".')
	image = [];
end

boundingBox = imageStruct.boundingBox(boundingBox_idx,:);

cropped = boundingBoxToCroppedColor(image,boundingBox);

if strcmp(colorStr,'bw')
	
	cellMask = boundingBoxToCellMask(image,boundingBox);
	
	imshow(cellMask,[],'InitialMagnification','fit')
	
elseif strcmp(colorStr,'red')
	
	imshow(cropped,redMap,'InitialMagnification','fit')
	
elseif strcmp(colorStr,'yel')

	imshow(cropped,yelMap,'InitialMagnification','fit')
	
elseif	strcmp(colorStr,'overlay')
	
	cellMask = boundingBoxToCellMask(redImage,boundingBox);
	edgeCellMask = imdilate(edge(cellMask),strel('disk',1));
	fused = imoverlay(cropped,edgeCellMask,'m');
	imshow(fused)
	
else
	
	disp('Please enter "red", "yel" or "bw".')
	
end

end

