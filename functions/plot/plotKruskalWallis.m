function [ pValue,outputStats ] = plotKruskalWallis( statsData,group )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

colors = get(groot,'DefaultAxesColorOrder');

[pValue,~,outputStats]=kruskalwallis(statsData,group,'on');
	set(gcf,'position',[10 10 480 600])
	set(gca,'fontsize',18)
	ylhand = get(gca,'ylabel');
	set(ylhand,'string','F_{mCherry,cell}','fontsize',24)
	boxH = get(get(gca,'children'),'children');   % Get the handles of all the objects
	tags = get(boxH,'tag');   % List the names of all the objects
	outliers = boxH(1:3);		% see tags for explanation of indexes
	medians = boxH(4:6);
	boxWT = boxH(9);
	boxR1070W = boxH(7);
	boxF508del = boxH(8);
	set(outliers,'MarkerEdgeColor', [0.5 0.5 0.5]);
	set(medians, 'Color', 'k');
% 	set(boxWT,'color', colors(2,:));
	patch(get(boxWT,'XData'),get(boxWT,'YData'),colors(2,:),'FaceAlpha',.5);
	patch(get(boxR1070W,'XData'),get(boxR1070W,'YData'),colors(4,:),'FaceAlpha',.5);
	patch(get(boxF508del,'XData'),get(boxF508del,'YData'),colors(6,:),'FaceAlpha',.5);


end

