function plotTestForNormalityQuench( resultsStruct )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

colors = get(groot,'DefaultAxesColorOrder');

maxGradTest = horzcat(resultsStruct.maxGradTest);

fig = figure;
ax = axes(fig);
hist = histogram(ax,maxGradTest,0:0.05:6);
	box on
	set(gca,'fontsize',20)
	xlim([0 6])
	ylim([0 350])
	xLab = xlabel('F_{YFP,membrane} / F_{mCh,cell}');
	set(xLab,'fontsize',24)
	yLab = ylabel('Frequency');
	set(yLab,'fontsize',24)
	annotation('textbox',[0.65 0.7 0.1 0.1]...
		,'string',sprintf('N = %d',length(maxGradTest))...
		,'fitboxtotext','on','fontsize',22)
	switch resultsStruct.mutation
		case 'WT'
			hist.FaceColor = colors(2,:);
		case 'F508del/R1070W'
			hist.FaceColor = colors(4,:);
		case 'F508del'
			hist.FaceColor = colors(6,:);
	end

figure
qq = qqplot(maxGradTest);
	box on
	switch resultsStruct.mutation
		case 'WT'
			set(qq(1),'MarkerEdgeColor', colors(2,:));
		case 'F508del/R1070W'
			set(qq(1),'MarkerEdgeColor', colors(4,:));
		case 'F508del'
			set(qq(1),'MarkerEdgeColor', colors(6,:));
	end
	set(qq(2),'color', 'k')
	set(qq(3),'color', 'k')
	set(gca,'fontsize',20)
	set(qq(1),'marker','.','markersize',15)
	title('')
	yLab = ylabel(sprintf('F_{YFP,membrane} / F_{mCh,cell}\nQuantiles'));
	set(yLab,'fontsize',24)


end

