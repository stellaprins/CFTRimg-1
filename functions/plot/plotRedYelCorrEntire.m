function plotRedYelCorrEntire( conditionStruct )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mutation = conditionStruct.mutation{1};
redEntire = vertcat(conditionStruct.imageLocal.redEntire);

yelEntire		= vertcat(conditionStruct.imageLocal.yelEntire);
yelOutside	= vertcat(conditionStruct.imageLocal.yelOutside);
yelMembrane	= vertcat(conditionStruct.imageLocal.yelMembrane);

yelRatioMembraneIn	= yelMembrane ./ yelEntire;
yelRatioOutIn		= yelOutside ./ yelEntire;

hits = yelRatioOutIn < 0.9 & yelRatioMembraneIn > 1;
hitN = sum(hits);

% nonResult = sum(isnan(redInside));
pointN = length(redEntire);

redEntireHit = zeros(hitN,1);
yelEntireHit = zeros(hitN,1);
redEntireMiss = zeros(pointN - hitN,1);
yelEntireMiss = zeros(pointN - hitN,1);

counterHit=1;
counterMiss=1;
for i=1:pointN
	if hits(i) == 1
		redEntireHit(counterHit) = redEntire(i);
		yelEntireHit(counterHit) = yelEntire(i);
		counterHit = counterHit + 1;
	elseif hits(i) == 0
		redEntireMiss(counterMiss) = redEntire(i);
		yelEntireMiss(counterMiss) = yelEntire(i);
		counterMiss = counterMiss + 1;
	end
end

R = corrcoef(redEntire,yelEntire);
r = R(1,2);

redSTD = std(redEntire);
yelSTD = std(yelEntire);

slope = r*(yelSTD/redSTD);
intercept = mean(yelEntire) - slope*mean(redEntire);

dim = [.65 .7 .2 .2];
str = sprintf('R = %0.5f\nslope = %0.5f\nintercept = %0.5f\npoints=%d'...
	,r,slope,intercept,pointN);

xmax = max(redEntire)*1.1;

x=0:0.001:xmax;
y=slope*x + intercept;

plot(redEntireMiss,yelEntireMiss,'bo'), hold on
plot(redEntireHit,yelEntireHit,'r*')
plot(x,y,'k.')
lsline
title(sprintf('%s - Entire',mutation))
xlabel('Mean mCherry fluorescence inside the entire cell')
ylabel('Mean YFP fluorescence inside the entire cell')
xlim([0 0.06])
ylim([0 0.042])
annotation('textbox',dim,'String',str,'FitBoxToText','on','fontsize',13);

set(gca,'fontsize',16)

end