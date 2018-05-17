function plotYelOverTime(resQ)
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here

colors          = get(groot,'DefaultAxesColorOrder');
x = 0:2:138;
x = x(1:66);

fors = resQ.yelInsideOverTTest;
fors = fors';
fors = fors(5:70,:);
ctrl = resQ.yelInsideOverTControl;
ctrl = ctrl';
ctrl = ctrl(5:70,:);

f = size(fors);
f = f(2);
for  i = 1:f;
	fors_i=fors(:,i);
	plot(x,fors_i,'r');
	hold on
end

c = size(ctrl);
c = c(2);
for i = 1:c
	ctrl_i=ctrl(:,i);
	plot(x,ctrl_i,'b');
	ylim([0 1.3]);
	hold on
end

	ylim([0 1.3]);
	xlhand = get(gca,'xlabel');
	set(xlhand,'string','Time (s)','fontsize',10)
	ylhand = get(gca,'ylabel');
	set(ylhand,'string','F/F_{max}','fontsize',10)
  title([resQ.mutation]);

p1 = plot(nan,nan,'-','color',colors(5,:),'linewidth',1);
p2 = plot(nan,nan,'-', 'linewidth',1);
plot([0 0],[0 1.3],':k','markersize',1)
plot([40 40],[0 1.3],':k','markersize',1)
% a1=annotation('textbox',[0.165 0.22 0.05 0.05],'string',sprintf('Iodide\naddition'),'fitboxtotext','on');
% a2=annotation('textbox',[0.38 0.22 0.05 0.05],'string',sprintf('Forskolin\naddition'),'fitboxtotext','on');
ylim([0 1.3])
xlim([-5 140])	
	
end

