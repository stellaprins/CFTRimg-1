function plotFOverDistance( imageStruct,idx )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

redImage = imread(imageStruct.redPath);
yelImage = imread(imageStruct.yelPath);

yelBackground = imageStruct.yelBackground * 65535; 
redBackground = imageStruct.redBackground * 65535;
% 65535 is the max F of a uint16 image

boundingBox = imageStruct.boundingBox(idx,:);
binning			= imageStruct.binning;

redCropped = boundingBoxToCroppedImage(redImage,boundingBox,binning) - redBackground;
yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox,binning) - yelBackground;

cellMask = boundingBoxToCellMask(redImage,boundingBox,binning);

if sum(cellMask(:)) == 0
	return
end

distanceMap = cellMaskToDistanceMap(cellMask);
distanceGroups = distanceMap - min(distanceMap(:)) + 1;
distanceLabels = unique(distanceMap) + (unique(distanceMap) >= 0);

yelMeanData = splitapply(@mean,yelCropped(:),distanceGroups(:));
redMeanData = splitapply(@mean,redCropped(:),distanceGroups(:));

yMinLeft = min(yelMeanData) - 0.1*range(yelMeanData);
yMaxLeft = max(yelMeanData) + 0.1*range(yelMeanData);
yMinRight = min(redMeanData) - 0.1*range(redMeanData);
yMaxRight = max(redMeanData) + 0.1*range(redMeanData);
xMin = -50; % min(distanceLabels);
xMax = 50; % max(distanceLabels);

horzLine	= linspace(xMin,xMax,3)';
vertLine	= linspace(yMinLeft,yMaxLeft,3)';

horzZeros = zeros(length(horzLine),1);
vertZeros = zeros(length(vertLine),1);
vertOnes	= ones(length(vertLine),1);

% axes('fontsize',18)
yyaxis left
plot(distanceLabels, yelMeanData)
xlim([xMin xMax])
ylim([yMinLeft yMaxLeft])
xlabel('Distance from the cell membrane (pixels)')
ylabel('Mean YFP fluorescence')

hold on
plot(vertZeros,vertLine,'k--') 
plot(10*vertOnes,vertLine,'k:','linewidth',1.2)
plot(horzLine,horzZeros,'k-')

yyaxis right
plot(distanceLabels, redMeanData)
ylim([yMinRight yMaxRight])
ylabel('Mean mCherry fluorescence')

title('Fluorescence over distance')

set(gca,'fontsize',16)
set(gca,'activepositionproperty','outerposition')

end

