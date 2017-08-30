
for b  = 1:length(cond)
    MembraneDensity = resultsStruct(b).yelMembrane./resultsStruct(b).redEntire;
    subplot(round(sqrt((length(cond)/2))),round(sqrt((length(cond)*2))),b);
    qqplot(MembraneDensity);
    yLab = ylabel(sprintf('F_{YFP,membrane} / F_{mCh,cell}\nQuantiles'));
	set(yLab,'fontsize',9)
    xLab = xlabel(sprintf('Standard Normal Quantiles'));
    set(xLab,'fontsize',8)
    title(cond(b).mutation);
end

figure;

for b  = 1:length(cond)
    MembraneDensity = resultsStruct(b).yelMembrane./resultsStruct(b).redEntire;
    subplot(round(sqrt((length(cond)/2))),round(sqrt((length(cond)*2))),b);
    hist(MembraneDensity);
    xLab = xlabel('F_{YFP,membrane} / F_{mCh,cell}');
	set(xLab,'fontsize',9)
	yLab = ylabel('Frequency');
	set(yLab,'fontsize',8)
    title(cond(b).mutation);
end

