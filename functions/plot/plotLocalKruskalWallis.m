function [ pValue,outputStats ] = plotLocalKruskalWallis( statsData,group )
%PLOT_LOCAL_KRUSKAL_WALLIS create box plot for all conditions
%   The Kruskal-Wallis function compares the likelihood of data being from
%   different groups, if the data are not normally distributed, The
%   functions requires that the data are given in a single array, and the
%   group names (or condition names) are in a different array. These arrays
%   are 'statsData' and 'group' respectively.

conditionN = length(unique(group));

[pValue,~,outputStats] =	kruskalwallis(statsData,group,'on');
ylim				  ([-.5 ceil(max(statsData))])
set					 (gca,'fontsize',12)
ylhand				= get(gca,'ylabel');
set						(ylhand,'string','\rho_{CFTR,membrane}','fontsize',12)

% get the handles of all the objects
boxH					= get(get(gca,'children'),'children');   

% list the names of all the objects
tags					= get(boxH,'tag');	

% see tags for explanation of indexes
outliers			= boxH(1:conditionN);														
medians				= boxH(conditionN + 1 : 2*conditionN);
boxes    			= boxH(2*conditionN + 1 : 3*conditionN);
whiskers 			= boxH(5*conditionN + 1 : 7 * conditionN);					
set						(outliers,'Color', 'k','LineWidth',1,...
							'Marker','.','MarkerFaceColor', 'k', 'MarkerSize',1);
set						(medians, 'Color', 'k','LineWidth',2); 
set						(boxes,'Color', 'k','LineWidth',2);
set						(whiskers,'Color', 'k','LineWidth',2);
set						(gca,'TickDir','out');
set						(gca,'FontName','Arial','FontSize',12,'FontWeight','Bold','LineWidth',2);
set						(findobj(gca,'type','line'),'linew',2);
% xtickangle(45)	% sets angle of x-axis lables 
									% (use 45 or 90 for long condition names)
box off						% removes box surrounding figure

end
