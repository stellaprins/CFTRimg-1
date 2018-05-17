function stats = plotLocalRedYelCorr( resultsStruct,yelRegion )
%PLOT_LOCAL_RED_YEL_CORR scatter plot of yelRegion against redEntire
%   The user can choose to either plot yelEntire against redEntire, or
%   yelMembrane against redEntire by changing the second parameter
%   'yelRegion'.
%
%		This function creates a scatter plot and also outputs the correlation
%		statistics, R the Pearson correlation coefficient, the slope of the
%		linear line of best fit and MSE, the mean-squared error.

redEntire   = resultsStruct.redEntire;
switch yelRegion
	case 'entire'
		yelData		= resultsStruct.yelEntire;
	case 'membrane'
		yelData		= resultsStruct.yelMembrane;
end

maxX = max(redEntire) * 1;
[slope, ~, stats] = glmfit(redEntire,yelData,'normal','constant','off');

R = corrcoef(redEntire,yelData);
if size(R) == [2 2]
	r = R(1,2);
	else
	r = 1;
end
    
MSE = sum(stats.resid .^2) / length(stats);

stats = [r slope MSE];

plot(redEntire,yelData,'o')
hold on
set(gca,'fontsize',10)
plot([0 maxX],[0 maxX*slope],'-')
ylhand = get(gca,'ylabel');
switch yelRegion
	case 'entire'
		set(ylhand,'string','F_{YFP,cell}','fontsize',10)
	case 'membrane'
		set(ylhand,'string','F_{YFP,membrane}','fontsize',10)
end
xlhand = get(gca,'xlabel');
set(xlhand,'string','F_{mCh,cell}','fontsize',10)
% xlim([0 0.12])
% ylim([0 0.08])
title(resultsStruct.mutation,'fontsize',10);

end
