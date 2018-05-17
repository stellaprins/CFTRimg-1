function plotFOverDistance( imageStruct,idx )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

redImage = imread(imageStruct.redPath);
yelImage = imread(imageStruct.yelPath);

yelBackground = imageStruct.yelBackground * 65535;
redBackground = imageStruct.redBackground * 65535;

boundingBox = imageStruct.boundingBox(idx,:);

redCropped = boundingBoxToCroppedImage(redImage,boundingBox) - redBackground;
yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox) - yelBackground;

cellMask = boundingBoxToCellMask(redImage,boundingBox);

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

horzLine = [xMin:1:xMax]';
vertLine = [yMinLeft:0.0001:yMaxLeft]';

% axes('fontsize',18)
yyaxis left
plot(distanceLabels, yelMeanData)
xlim([xMin xMax])
ylim([yMinLeft yMaxLeft])
xlabel('Distance from the cell membrane (pixels)')
ylabel('Mean YFP fluorescence')

hold on 
plot(zeros(length(vertLine),1),vertLine,'k--') 
plot(10*ones(length(vertLine),1),vertLine,'k:','linewidth',1.2)
plot(horzLine,zeros(length(horzLine),1),'k-')

yyaxis right
plot(distanceLabels, redMeanData)
ylim([yMinRight yMaxRight])
ylabel('Mean mCherry fluorescence')

title('Fluorescence over distance')

set(gca,'fontsize',16)

end

