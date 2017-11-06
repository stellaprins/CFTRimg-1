function plotYelOverTimeCollated( resultsStruct )
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here

colors          = get(groot,'DefaultAxesColorOrder');

yelTest					= (resultsStruct.yelInsideOverTTest)';
yelControl			= resultsStruct.yelInsideOverTControl';

meanYelTest         = mean((yelTest),2);
meanYelControl      = mean((yelControl),2);
errYelTest          = std((yelTest),0,2);
errYelControl       = std((yelControl),0,2);

x = 0:2:138;

shadedErrorBar(x,meanYelControl,errYelControl...
	,'lineprops',{'.','color',colors(5,:),'linewidth',0.8});
hold on;
shadedErrorBar(x,meanYelTest(),errYelTest()...
	,'lineprops',{'.','linewidth',0.8});
p1 = plot(nan,nan,'-','color',colors(5,:),'linewidth',1);
p2 = plot(nan,nan,'-', 'linewidth',1);
plot([0 0],[0 1.3],':k','markersize',1)
plot([40 40],[0 1.3],':k','markersize',1)
% a1=annotation('textbox',[0.165 0.22 0.05 0.05],'string',sprintf('Iodide\naddition'),'fitboxtotext','on');
% a2=annotation('textbox',[0.38 0.22 0.05 0.05],'string',sprintf('Forskolin\naddition'),'fitboxtotext','on');
ylim([0 1.3])
xlim([-5 140])

title(resultsStruct.mutation)
xlhand = get(gca,'xlabel');
set(xlhand,'string','Time (s)','fontsize',10)
ylhand = get(gca,'ylabel');
set(ylhand,'string','F/F_{max}','fontsize',10)

% legend([p1 p2],'DMSO','DMSO + Forskolin','location','northeast')
% set(gca,'fontsize',10)
% a1.FontSize = 10;
% a2.FontSize = 10;

end

