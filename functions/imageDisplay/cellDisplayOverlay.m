function cellDisplayOverlay(imageStruct, colorStr...
	,cellMask, membraneMask, boundingBox_idx )
%CELLDISPLAY Summary of this function goes here
%   Detailed explanation goes here

switch colorStr
	case 'yelOverlay'
		yelImage = imadjust(im2double(imread(imageStruct.yelPath)));
		
		[imX,map] = gray2ind(yelImage,256);
		yelMap = [map(:,1),map(:,1),zeros(256,1)];
		yelImage = ind2rgb(imX,yelMap);
		
		boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
		cropped = boundingBoxToCroppedColor(yelImage,boundingBox);
		
		seUnit = strel('disk',1);
		dilatedMask = imdilate(membraneMask,seUnit);
		edgeMemMask = edge(dilatedMask);
		fused = imoverlay(cropped,edgeMemMask,'c');
		imshow(fused,'InitialMagnification','fit')
		set(gca,'position',[0 0 1 1])
% 		title('Cell component')
case 'redOverlay'
		redImage = imadjust(im2double(imread(imageStruct.redPath)));
		[imX,map] = gray2ind(redImage,256);
		redMap = [map(:,1),zeros(256,1),zeros(256,1)];
		redImage = ind2rgb(imX,redMap);
		
		boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
		cropped = boundingBoxToCroppedColor(redImage,boundingBox);
		
		seUnit = strel('disk',1);
		dilatedMask = imdilate(cellMask,seUnit);
		edgeCellMask = imdilate(edge(dilatedMask),seUnit);
		fused = imoverlay(cropped,edgeCellMask,'c');
		imshow(fused,'InitialMagnification','fit')
		set(gca,'position',[0 0 1 1])
% 		title('Cell component')
	otherwise
		disp('Please enter "redOverlay" or "yelOverlay".')
		return
end

set(gca,'fontsize',14)

end

