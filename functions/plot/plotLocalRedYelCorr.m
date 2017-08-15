function plotLocalRedYelCorr( conditionStruct,yelRegion )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mutation = conditionStruct.mutation{1};
redEntire = vertcat(conditionStruct.imageLocal.redEntire);

if strcmp(yelRegion,'entire')
	yelData		= vertcat(conditionStruct.imageLocal.yelEntire);
elseif strcmp(yelRegion,'membrane')
	yelData		= vertcat(conditionStruct.imageLocal.yelMembrane);
elseif strcmp(yelRegion,'interior')
	yelData		= vertcat(conditionStruct.imageLocal.yelInterior);
end
	
pointN = length(redEntire);

R = corrcoef(redEntire,yelData);
r = R(1,2);

redSTD = std(redEntire);
yelSTD = std(yelData);

slope = r*(yelSTD/redSTD);
intercept = mean(yelData) - slope*mean(redEntire);

dim = [.65 .7 .2 .2];
str = sprintf('R = %0.5f\nslope = %0.5f\nintercept = %0.5f\npoints=%d'...
	,r,slope,intercept,pointN);

plot(redEntire,yelData,'bo'), hold on
lsline
title(sprintf('%s - %s',mutation,yelRegion))
xlabel('Mean mCherry fluorescence')
ylabel('Mean YFP fluorescence')
xlim([0 0.06])
ylim([0 0.042])
annotation('textbox',dim,'String',str,'FitBoxToText','on','fontsize',13);

set(gca,'fontsize',16)

end