function [ pValue,outputStats ] = plotKruskalWallis( statsData,group ) 
  colors			= get(groot,'DefaultAxesColorOrder');
  [pValue,~,outputStats] =	kruskalwallis(statsData,group,'on');
	ylim				  ([0 5])
	set					 (gcf,'position',[10 10 480 600])
	set					 (gca,'fontsize',9)
	ylhand				= get(gca,'ylabel');
	set						(ylhand,'string','F_{YFP,membrane}/F_{mCherry,cell}','fontsize',12)
	boxH					= get(get(gca,'children'),'children');   % Get the handles of all the objects
	tags					= get(boxH,'tag');                       % List the names of all the objects
 	outliers			= boxH(1:5);                         % see tags for explanation of indexes
	medians				= boxH(4:6);
	set						(outliers,'MarkerEdgeColor', [0.5 0.5 0.5]);
	set						(medians, 'Color', 'k');
end

