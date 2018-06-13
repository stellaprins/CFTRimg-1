function out = plotLocalSizeRhoCorr( resultsStruct , expStruct )
%PLOT_LOCAL_RHO_SIZE_CORR scatter plot of cell area against the metric Rho
%   This can be used to see whether there is any effect of cell size on the
%   metric Rho.

cellLoc = resultsStruct.cellLocation;
cellArea = zeros(length(cellLoc),1);
uniqueExpImage = unique(cell2mat(resultsStruct.cellLocation(:,2:3)),'rows');

counter = 1;
for j=1:size(uniqueExpImage,1)
	expNo = uniqueExpImage(j,1);
	imageNo = uniqueExpImage(j,2);
	image = im2double(imread(expStruct(expNo).imageLocal(imageNo).redPath));
	boundingBoxes = expStruct(expNo).imageLocal(imageNo).boundingBox(:,:);
	for i = 1:size(boundingBoxes,1)
		cellMask = boundingBoxToCellMask(image,boundingBoxes(i,:));
		[labelled, ~] = bwlabel(cellMask,8);
		properties = regionprops(labelled ...
			,'MinorAxisLength','MajorAxisLength','Area','Perimeter');
 		cellArea(counter) = properties.Area;
		counter = counter + 1;
	end
end


rho = resultsStruct.memDens;


maxX = max(cellArea) * 1;
[slope, ~, stats] = glmfit(cellArea,rho,'normal');

R = corrcoef(cellArea,rho);
if size(R) == [2 2]
	r = R(1,2);
	else
	r = 1;
end
    
MSE = sum(stats.resid .^2) / length(stats.resid);

stats = [r slope(2) MSE];

plot(cellArea,rho,'o')
hold on
set(gca,'fontsize',10)
plot([0 maxX],[slope(1) maxX*slope(2) + slope(1)],'-')
ylhand = get(gca,'ylabel');
set(ylhand,'string','\rho','fontsize',10)
xlhand = get(gca,'xlabel');
set(xlhand,'string','Cell component area','fontsize',10)
dim = [0.2 0.5 0.3 0.3];
str = {sprintf('R = %.3f\nslope = %.6f\nMSE = %.5f',stats(1),stats(2),stats(3))};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
titleStr = strcat({resultsStruct.condition},...
	{'\nnorm '},{resultsStruct.normCondition});
title(sprintf(titleStr{1}),'fontsize',10)

condition = {resultsStruct.condition};

out = vertcat(condition,num2cell(stats'));

end
