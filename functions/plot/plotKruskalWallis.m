function [ pValue,outputStats ] = plotKruskalWallis( statsData,group ) 
   colors									= get(groot,'DefaultAxesColorOrder');
  [pValue,~,outputStats] =	kruskalwallis(statsData,group,'on');
	ylim				  ([0 8])
	set					 (gcf,'position',[10 10 480 600])
	set					 (gca,'fontsize',14)
	ylhand				= get(gca,'ylabel');
	set						(ylhand,'string','F_{YFP,membrane}/F_{mCherry,cell}','fontsize',12)
	boxH					= get(get(gca,'children'),'children');   % Get the handles of all the objects
	tags					= get(boxH,'tag');                       % List the names of all the objects
 	outliers			= boxH(1:6);														% see tags for explanation of indexes
	medians				= boxH(7:12);
	box     			= boxH(12:18);														% see tags for explanation of indexes
	whiskers 			= boxH(31:42);					
	set						(outliers,'Color', 'r','linew',.5, 'Marker','.');
	set						(medians, 'Color', 'k')%;'linew',1); 
  set						(box,'Color', 'k')%;'linew',1);
  set						(whiskers,'Color', 'k');%'linew',1);
	set						(gca,'TickDir','out');
	%set					(findobj(gca,'type','line'),'linew',1.5);
end
