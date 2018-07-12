function cellDisplay(imageStruct, colorStr, boundingBox_idx )
%CELLDISPLAY Summary of this function goes here
%   Detailed explanation goes here

switch colorStr
	case 'red'
		image       = imadjust(im2double(imread(imageStruct.redPath)));
		[imX,map]   = gray2ind(image,256);
		redMap      = [map(:,1),zeros(256,1),zeros(256,1)];
		image       = ind2rgb(imX,redMap);
		boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
		binning			= imageStruct.binning;
		cropped     = boundingBoxToCroppedColor(image,boundingBox,binning);
		imshow(cropped,redMap,'InitialMagnification','fit')
 %		set(gca,'position',[0 0 1 1])
 		title('mCherry')
	case 'yel'
		image       = imadjust(im2double(imread(imageStruct.yelPath)));
		[imX,map]   = gray2ind(image,256);
		yelMap      = [map(:,1),map(:,1),zeros(256,1)];
		image       = ind2rgb(imX,yelMap);
		boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
		binning			= imageStruct.binning;
		cropped     = boundingBoxToCroppedColor(image,boundingBox,binning);
		imshow(cropped,yelMap,'InitialMagnification','fit')
% 		set(gca,'position',[0 0 1 1])
 		title('YFP')
	case 'bw'
		image       = im2double(imread(imageStruct.redPath));
		boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
		binning			= imageStruct.binning;
		cellMask    = boundingBoxToCellMask(image,boundingBox,binning);
		imshow(cellMask,[],'InitialMagnification','fit')
 %		set(gca,'position',[0 0 1 1])
  		title('BW component')
	otherwise
		disp('Please enter "red", "yel", "bw".')
		return
end

set(gca,'fontsize',9)

end

