function [ pValue,outputStats ] = plotKruskalWallisQuench( statsData,group ) 
   colors									= get(groot,'DefaultAxesColorOrder');
  [pValue,~,outputStats] =	kruskalwallis(statsData,group,'on');
   ylim				  ([-.03 .3])
% 	set					 (gcf,'position',[10 10 480 600])
% 	set					 (gca,'fontsize',14)
	ylhand				= get(gca,'ylabel');
	set						(ylhand,'string','d[I^{-}]/dt (µM/s)','fontsize',12)
%	set						(ylhand,'max rate iodide entry(uM/s)','fontsize',12) %''
	boxH					= get(get(gca,'children'),'children');   % Get the handles of all the objects
	tags					= get(boxH,'tag');                       % List the names of all the objects
 	outliers			= boxH(1:10);														% see tags for explanation of indexes
	medians				= boxH(11:20);
	box     			= boxH(21:30);														% see tags for explanation of indexes
% 	whiskers 			= boxH(31:42);					
	set						(outliers,'Color', 'r','linew',.5, 'Marker','.');
	set						(medians, 'Color', 'k')%;'linew',1); 
  set						(box,'Color', 'k')%;'linew',1);
  set						(whiskers,'Color', 'k');%'linew',1);
	set						(gca,'TickDir','out');
% 	set					(findobj(gca,'type','line'),'linew',1.5);
end
