function plotLocalQQPlot( resultsStruct , M , N )
%PLOT_LOCAL_QQ_PLOT QQplot for each condition in separate subplot
%   The qq plots show how close to normally distributed the data are.

conditionN = length(resultsStruct);

figure
for i = 1:conditionN
	
	membraneDensity = resultsStruct(i).yelMembrane./resultsStruct(i).redEntire;
	
	subplot(M,N,i);
		qqplot(membraneDensity)
		xlim([-3 3])
		yLab = ylabel(sprintf('F_{YFP,membrane} / F_{mCh,cell}\nQuantiles'));
		set(yLab,'fontsize',9)
		xLab = xlabel(sprintf('Standard Normal Quantiles'));
		set(xLab,'fontsize',8)
		title(resultsStruct(i).mutation);
		
end

end

