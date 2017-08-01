function plotMeanIntensity( imageStruct,idx )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

redImage = imread(imageStruct.redPath);
yelImage = imread(imageStruct.yelPath);

yelBackground = imageStruct.yelBackground;
redBackground = imageStruct.redBackground;


boundingBox = imageStruct.boundingBox(idx,:);

redCropped = boundingBoxToCroppedImage(redImage,boundingBox);
yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox);

redCropAdj = im2double(redCropped) - redBackground;
yelCropAdj = im2double(yelCropped) - yelBackground;

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
xMin = -50; % min(distanceLabels);
xMax = 50; % max(distanceLabels);

horzLine = [xMin:1:xMax]';
vertLine = [yMinLeft:0.0001:yMaxLeft]';

% axes('fontsize',18)
yyaxis left
plot(distanceLabels, yelMeanData ...
	,zeros(length(vertLine),1),vertLine ...
	,10*ones(length(vertLine),1),vertLine ...
	,horzLine,zeros(length(horzLine),1))
xlim([xMin xMax])
ylim([yMinLeft yMaxLeft])
xlabel('Distance from the cell membrane (pixels)')
ylabel('Mean YFP fluorescence')

yyaxis right
plot(distanceLabels, redMeanData)
ylim([yMinRight yMaxRight])
ylabel('Mean mCherry fluorescence')
	


end

