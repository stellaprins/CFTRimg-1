function [ imageStruct ] = imgFilterAbuttingCells( imageStruct )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

image = imread(imageStruct.redPath);
redBackground = imageStruct.redBackground;

counter = 1;
for idx=1:imageStruct.cellN(end)
	
	boundingBox = imageStruct.boundingBox(idx,:);

	redCropped = boundingBoxToCroppedImage(image,boundingBox);
	
	redCropAdj = im2double(redCropped) - redBackground;
	
	bw = cellBinarize(redCropAdj);
	
	edgeMask = zeros(size(redCropAdj));
	edgeMask(1,:) = 1;
	edgeMask(size(redCropAdj,1),:) = 1;
	edgeMask(:,:) = 1;
	edgeMask(:,size(redCropAdj,2)) = 1;
	
	limit = sum(edgeMask(:))/2;
	
	edgeComponent = edgeMask .* bw;
	edgePixels = sum(edgeComponent(:));
	
	if edgePixels < limit
		imageStruct.boundingBox(counter,:) = imageStruct.boundingBox(idx,:);
		counter = counter + 1;
	end
	
end
	
imageStruct.cellN(1,end+1) = counter - 1;

end

