function plotFOverDistance_SP( imageStruct,idx )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

left_color = [.5 .5 0];
right_color = [.5 .5 .5];

redImage = imread(imageStruct.redPath);
yelImage = imread(imageStruct.yelPath);

yelBackground = imageStruct.yelBackground * 65535;
redBackground = imageStruct.redBackground * 65535;

boundingBox = imageStruct.boundingBox(idx,:);

redCropped = boundingBoxToCroppedImage(redImage,boundingBox) - redBackground;
yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox) - yelBackground;

redCropped_contrast = imadjust(redCropped);
yelCropped_contrast = imadjust(yelCropped);

cellMask = boundingBoxToCellMask(redImage,boundingBox);

if sum(cellMask(:)) == 0
	return
end

distanceMap = makeDistanceMap(cellMask);
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
plot(distanceLabels, yelMeanData,'Color',[.9 0.85 0], 'LineWidth', 2)
xlim([xMin xMax])
xticks([xMin:10:xMax])
ylim([yMinLeft yMaxLeft])
xlabel('Distance from the membrane (pixels)')
ylabel('F_{YFP}','Color',[.9 0.85 0])
set(gca,'ycolor',[.85 0.75 0]) 

hold on 
plot(zeros(length(vertLine),1),vertLine,'k:',  'LineWidth', 1) 
plot(10*ones(length(vertLine),1),vertLine,'k:',  'LineWidth', 1)
plot(horzLine,zeros(length(horzLine),1),'k:',  'LineWidth', 1)

yyaxis right
plot(distanceLabels, redMeanData,'Color','k','LineStyle','--',  'LineWidth', 2)
ylim([yMinRight yMaxRight])
ylabel('F_{mCherry}','Color','k')

% title('Fluorescence over distance')

set(gca,'fontsize',12)
set(gca,'ycolor','k') 
box off
set(gca,'FontName','Arial','FontSize',12,'FontWeight','Bold',  'LineWidth', 2);
end

