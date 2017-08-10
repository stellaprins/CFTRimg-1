function plotRedYelCorrMembrane( conditionStruct )
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
yelMembraneHit = zeros(hitN,1);
redEntireMiss = zeros(pointN - hitN,1);
yelMembraneMiss = zeros(pointN - hitN,1);

counterHit=1;
counterMiss=1;
for i=1:pointN
	if hits(i) == 1
		redEntireHit(counterHit) = redEntire(i);
		yelMembraneHit(counterHit) = yelMembrane(i);
		counterHit = counterHit + 1;
	elseif hits(i) == 0
		redEntireMiss(counterMiss) = redEntire(i);
		yelMembraneMiss(counterMiss) = yelMembrane(i);
		counterMiss = counterMiss + 1;
	end
end

R = corrcoef(redEntire,yelMembrane);
r = R(1,2);

redSTD = std(redEntire);
yelSTD = std(yelMembrane);

slope = r*(yelSTD/redSTD);
intercept = mean(yelMembrane) - slope*mean(redEntire);

dim = [.65 .7 .2 .2];
str = sprintf('R = %0.5f\nslope = %0.5f\nintercept = %0.5f\npoints=%d'...
	,r,slope,intercept,pointN);

xmax = max(redEntire)*1.1;

x=0:0.001:xmax;
y=slope*x + intercept;

plot(redEntireMiss,yelMembraneMiss,'bo'), hold on
plot(redEntireHit,yelMembraneHit,'ro')
plot(x,y,'k.')
lsline

title(sprintf('%s - Membrane',mutation))
xlabel('Mean mCherry fluorescence inside the entire cell')
ylabel('Mean YFP fluorescence inside the membrane')
xlim([0 0.06])
ylim([0 0.042])
annotation('textbox',dim,'String',str,'FitBoxToText','on','fontsize',13);

set(gca,'fontsize',16)

end