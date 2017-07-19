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
	redCropAdj = im2double(redCropped) - background;
	yelCropAdj = im2double(yelCropped) - background;
	
	cellMask = cellBinarize(redCropped);
	
	distanceMap = makeDistanceMap(cellMask);
	distanceGroups = distanceMap - min(distanceMap(:)) + 1;
	distanceLabels = unique(distanceMap) + (unique(distanceMap) >= 0);

	yelMeanData = splitapply(@mean,yelCropAdj(:),distanceGroups(:));
	redMeanData = splitapply(@mean,redCropAdj(:),distanceGroups(:));
	
	yMinLeft = min(yelMeanData) - 0.1*range(yelMeanData);
	yMaxLeft = max(yelMeanData) + 0.1*range(yelMeanData);
	yMinRight = min(redMeanData) - 0.1*range(redMeanData);
	yMaxRight = max(redMeanData) + 0.1*range(redMeanData);
	xMin = min(distanceLabels);
	xMax = max(distanceLabels);
	
	horzLine = [xMin:1:xMax]';
	vertLine = [yMinLeft:0.0001:yMaxLeft]';
	
	figure
	yyaxis left
	plot(distanceLabels, yelMeanData ...
		,zeros(length(vertLine),1),vertLine ...
		,10*ones(length(vertLine),1),vertLine ...
		,horzLine,background*ones(length(horzLine),1))
	xlim([xMin xMax])
	ylim([yMinLeft yMaxLeft])
	xlabel('Distance from the cell membrane (pixels)')
	ylabel('Mean YFP fluorescence')
	
	yyaxis right
	plot(distanceLabels, redMeanData)
	ylim([yMinRight yMaxRight])
	ylabel('Mean mCherry fluorescence')
	
end


end

