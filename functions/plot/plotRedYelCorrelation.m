function plotRedYelCorrelation( conditionStruct )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mutation = conditionStruct.mutation;
yelInside = vertcat(conditionStruct.images.yelInsideCell);
redInside = vertcat(conditionStruct.images.redInsideCell);

R = corrcoef(redInside,yelInside);
r = R(1,2);

redSTD = std(redInside);
yelSTD = std(yelInside);

slope = r*(yelSTD/redSTD);
intercept = mean(yelInside) - slope*mean(redInside);

dim = [.7 .4 .2 .2];
str = sprintf('R = %0.5f\nslope = %0.5f\nintercept = %0.5f'...
	,r,slope,intercept);



figure
ax = axes;
scatter(redInside,yelInside)
lsline(ax)
title(mutation)
xlabel('Mean mCherry fluorescence inside the cell')
ylabel('Mean YFP fluorescence inside the cell')
xlim([0 0.12])
ylim([0 0.025])
annotation('textbox',dim,'String',str,'FitBoxToText','on');