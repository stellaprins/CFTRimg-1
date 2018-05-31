function [redCellImage, yelCellImage] = cellWithBorder(imageStruct, boundingBox_idx )
%CELL_WITH_BORDER create colour cell image with white line denoting the cell segmentation boundary

redBW = im2double(imread(imageStruct.redPath));
boundingBox = imageStruct.boundingBox(boundingBox_idx,:);
cellMask    = boundingBoxToCellMask(redBW,boundingBox);

redImage = imadjust(redBW);
yelImage = imadjust(im2double(imread(imageStruct.yelPath)));

[redImX,tmpRedMap] 	= gray2ind(redImage,256);
redMap      				= [tmpRedMap(:,1),zeros(256,1),zeros(256,1)];
redImage 						= ind2rgb(redImX,redMap);
redCropped     			= boundingBoxToCroppedColor(redImage,boundingBox);

[yelImX,tmpYelMap] 	= gray2ind(yelImage,256);
yelMap 							= [tmpYelMap(:,1),tmpYelMap(:,1),zeros(256,1)];
yelImage 						= ind2rgb(yelImX,yelMap);
yelCropped 					= boundingBoxToCroppedColor(yelImage,boundingBox);

edgeCellMask = edge(cellMask);

redCellImage = imoverlay(redCropped,edgeCellMask,'w');
yelCellImage = imoverlay(yelCropped,edgeCellMask,'w');		

end

