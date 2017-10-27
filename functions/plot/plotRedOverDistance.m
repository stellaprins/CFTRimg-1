function plotRedOverDistance( imageStruct,idx )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

colors = get(groot,'DefaultAxesColorOrder');

redImage = imread(imageStruct.redPath);

redBackground = imageStruct.redBackground * 65535;



boundingBox = imageStruct.boundingBox(idx,:);

redCropped = boundingBoxToCroppedImage(redImage,boundingBox) - redBackground;

cellMask = boundingBoxToCellMask(redImage,boundingBox);

if sum(cellMask(:)) == 0
	return
end

distanceMap = makeDistanceMap(cellMask);
distanceGroups = distanceMap - min(distanceMap(:)) + 1;
distanceLabels = unique(distanceMap) + (unique(distanceMap) >= 0);

redMeanData = splitapply(@mean,redCropped(:),distanceGroups(:));

yMin = min(redMeanData) - 0.1*range(redMeanData);
yMax = max(redMeanData) + 0.1*range(redMeanData);
xMin = -50; % min(distanceLabels);
xMax = 50; % max(distanceLabels);

horzLine = [xMin:1:xMax]';
vertLine = [yMin:0.0001:yMax]';

minRed = min(redImage(:));
maxRed = max(redImage(:));
refGradient = (maxRed - minRed) / 40;
intercept = min(redMeanData); % (yMin + yMax) / 2;
yMinGrad = intercept;
xMaxGrad = double(yMax - intercept) / double(refGradient); 

% axes('fontsize',18)
p1 = plot(distanceLabels, redMeanData,'color',colors(2,:),'linewidth',1);
xlim([xMin xMax])
ylim([yMin yMax])
xlabel('Distance from the cell membrane (pixels)')
ylabel('Mean mCherry fluorescence')

hold on 
plot(zeros(length(vertLine),1),vertLine,'k--') 
plot(10*ones(length(vertLine),1),vertLine,'k:','linewidth',1.2)
plot(horzLine,zeros(length(horzLine),1),'k-')
p2 = plot([0 xMaxGrad],[yMinGrad max(redMeanData)] ...
	,'-','color',colors(1,:),'linewidth',1);

legend([p1 p2],'Red fluorescence','Reference gradient','location','northwest')

title('mCherry fluorescence over distance')

set(gca,'fontsize',16)

end

