function plotMeanIntensity( imageStruct )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

redImage = imread(imageStruct.redPath);
yelImage = imread(imageStruct.yelPath);

cellN = imageStruct.cellN(end);
background = imageStruct.yelBackground;

for i=1:cellN
	
	boundingBox = imageStruct.boundingBox(i,:);

	redCropped = boundingBoxToCroppedImage(redImage,boundingBox);
	yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox);
	yelCropAdj = im2double(yelCropped) - background;
	
	cellMask = cellBinarize(redCropped);
	
	distanceMap = makeDistanceMap(cellMask);
	distanceGroups = distanceMap - min(distanceMap(:)) + 1;

	meanData = splitapply(@mean,yelCropAdj(:),distanceGroups(:));
	
	figure
	plot(meanData)
	
end


end

