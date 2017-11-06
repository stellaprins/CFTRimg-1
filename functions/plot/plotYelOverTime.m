function plotYelOverTime(resQ)
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here

fors = resQ.yelInsideOverTTest;
fors = fors';
ctrl = resQ.yelInsideOverTControl;
ctrl = ctrl';

f = size(fors);
f = f(2);
for  i = 1:f
	fors_i=fors(:,i);
	plot(1:70,fors_i,'r');
	hold on
end

c = size(ctrl);
c = c(2)
for i = 1:c
	ctrl_i=ctrl(:,i);
	plot(1:70,ctrl_i,'b');
	ylim([0 1.3]);
	hold on
end

	ylim([0 1.3]);
	xlabel('Timepoint');
	ylabel('Norm. adj. mean YFP fluorescence within cells');
  title([resQ.mutation]);

end

