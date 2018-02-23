function [ pValue,outputStats ] = plotKruskalWallis( statsData,group ) 
   colors									= get(groot,'DefaultAxesColorOrder');
  [pValue,~,outputStats] =	kruskalwallis(statsData,group,'on');
 	ylim				  ([-.5 10])
	set					 (gcf,'position',[10 10 480 600])
	set					 (gca,'fontsize',12)
	ylhand				= get(gca,'ylabel');
	set						(ylhand,'string','\rho_{CFTR,membrane}','fontsize',12)
	boxH					= get(get(gca,'children'),'children');   % Get the handles of all the objects
	tags					= get(boxH,'tag');                       % List the names of all the objects
 	outliers			= boxH(1:6);														% see tags for explanation of indexes
	medians				= boxH(7:12);
	boxes    			= boxH(12:18);														% see tags for explanation of indexes
	whiskers 			= boxH(31:42);					
	set						(outliers,'Color', 'k','LineWidth',1,...
								'Marker','.','MarkerFaceColor', 'k', 'MarkerSize',1);
	set						(medians, 'Color', 'k','LineWidth',2); 
	set						(boxes,'Color', 'k','LineWidth',2);
  set						(whiskers,'Color', 'k','LineWidth',2);
	set						(gca,'TickDir','out');
	set						(gca,'FontName','Arial','FontSize',12,'FontWeight','Bold',  'LineWidth', 2);
 	set						(findobj(gca,'type','line'),'linew',2);
% 	xtickangle(90)
	box off
end
