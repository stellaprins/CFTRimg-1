function cellDisplay(imageStruct, colorStr, boundingBox_idx )
%CELLDISPLAY Summary of this function goes here
%   Detailed explanation goes here

switch colorStr
	case 'red'
		image       = imadjust(im2double(imread(imageStruct.redPath)),[0.001 .2]);
		[imX,map]   = gray2ind(image,256);
		redMap      = [map(:,1),zeros(256,1),zeros(256,1)];
		image       = ind2rgb(imX,redMap);
		boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
		cropped     = boundingBoxToCroppedColor(image,boundingBox);
		imshow(cropped,redMap,'InitialMagnification','fit')
 %		set(gca,'position',[0 0 1 1])
 		title('mCherry')
	case 'yel'
		image       = imadjust(im2double(imread(imageStruct.yelPath)),[0.02 .05]);
		[imX,map]   = gray2ind(image,256);
		yelMap      = [map(:,1),map(:,1),zeros(256,1)];
		image       = ind2rgb(imX,yelMap);
		boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
		cropped     = boundingBoxToCroppedColor(image,boundingBox);
		imshow(cropped,yelMap,'InitialMagnification','fit')
% 		set(gca,'position',[0 0 1 1])
 		title('YFP')
	case 'bw'
		image       = im2double(imread(imageStruct.redPath));
		boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
		cellMask    = boundingBoxToCellMask(image,boundingBox);
		imshow(cellMask,[],'InitialMagnification','fit')
 %		set(gca,'position',[0 0 1 1])
  		title('BW component')
	otherwise
		disp('Please enter "red", "yel", "bw".')
		return
end

set(gca,'fontsize',9)

end

