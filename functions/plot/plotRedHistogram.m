function [ resultsStruct ] = plotRedHistogram( resultsStruct )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

colors = get(groot,'DefaultAxesColorOrder');

redEntire = resultsStruct.redEntire;

fig = figure;
ax = axes(fig);
hist = histogram(ax,redEntire);
	box on
	set(gca,'fontsize',20)
 	xlim([0 0.12])
 	ylim([0 500])
	xLab = xlabel('F_{mCherry,cell}');
	set(xLab,'fontsize',24)
	yLab = ylabel('Frequency');
	set(yLab,'fontsize',24)
	annotation('textbox',[0.65 0.7 0.1 0.1]...
		,'string',sprintf('N = %d',resultsStruct.localCellN)...
		,'fitboxtotext','on','fontsize',22)
	switch resultsStruct.mutation
		case 'WT'
			hist.FaceColor = colors(2,:);
		case 'F508del/R1070W'
			hist.FaceColor = colors(4,:);
		case 'F508del'
			hist.FaceColor = colors(6,:);
	end
end

