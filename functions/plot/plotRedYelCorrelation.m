function plotRedYelCorrelation( conditionStruct )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mutation = conditionStruct.mutation;
yelInside = vertcat(conditionStruct.imageLocal.yelInsideCell);
redInside = vertcat(conditionStruct.imageLocal.redInsideCell);

% nonResult = sum(isnan(redInside));
points = length(redInside);

R = corrcoef(redInside,yelInside);
r = R(1,2);

redSTD = std(redInside);
yelSTD = std(yelInside);

slope = r*(yelSTD/redSTD);
intercept = mean(yelInside) - slope*mean(redInside);

dim = [.65 .7 .2 .2];
str = sprintf('R = %0.5f\nslope = %0.5f\nintercept = %0.5f\npoints=%d'...
	,r,slope,intercept,points);

xmax = 1.05*max(redInside);
ymax = 1.05*max(yelInside);

scatter(redInside,yelInside)
lsline
title(mutation)
xlabel('Mean mCherry fluorescence inside the cell')
ylabel('Mean YFP fluorescence inside the cell')
xlim([0 0.06])
ylim([0 0.035])
annotation('textbox',dim,'String',str,'FitBoxToText','on','fontsize',13);

set(gca,'fontsize',16)

end