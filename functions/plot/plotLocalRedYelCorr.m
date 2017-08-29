function plotLocalRedYelCorr( resultsStruct,yelRegion )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

colors = get(groot,'DefaultAxesColorOrder');

mutation	= resultsStruct.mutation;
redEntire   = resultsStruct.redEntire;

switch yelRegion
	case 'entire'
		yelData		= resultsStruct.yelEntire;
	case 'membrane'
		yelData		= resultsStruct.yelMembrane;
end

maxX = max(redEntire) * 1;

switch mutation
	case 'WT'
		markerColor = colors(2,:);
		maxX = 0.08;
	case 'F508del/R1070W'
		markerColor = colors(4,:);
		maxX = 0.08;
	case 'F508del'
		markerColor = colors(6,:);
end

[slope, ~, stats] = glmfit(redEntire,yelData,'normal','constant','off');

R = corrcoef(redEntire,yelData);
r = R(1,2);



% redSTD = std(redEntire);
% yelSTD = std(yelData);
% 
% slope = redEntire(:)\yelData(:);
% intercept = mean(yelData) - slope*mean(redEntire);

MSE = sum(stats.resid .^2) / length(stats);

dim = [.654 .71 .2 .2];
str = sprintf('R = %0.3f\nslope = %0.3f\nMSE = %0.5f'...
	,r,slope,MSE);

plot(redEntire,yelData,'o')
hold on
set(gca,'fontsize',18)
plot([0 maxX],[0 maxX*slope],'-')
% title(sprintf('%s - %s',mutation,yelRegion))
ylhand = get(gca,'ylabel');
switch yelRegion
	case 'entire'
		set(ylhand,'string','F_{YFP,cell}','fontsize',22)
	case 'membrane'
		set(ylhand,'string','F_{YFP,membrane}','fontsize',22)
end
xlhand = get(gca,'xlabel');
set(xlhand,'string','F_{mCh,cell}','fontsize',22)
xlim([0 0.12])
ylim([0 0.08])
annotation('textbox',dim,'String',str,'FitBoxToText','on','fontsize',16);




end
