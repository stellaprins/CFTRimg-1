function plotMaxGradBarChart( resultsStructArray )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

colors = get(groot,'DefaultAxesColorOrder');

conditionN = length(resultsStructArray);
maxGrad = zeros(2,conditionN);
errorGrad = zeros(2,conditionN);

for i = 1:conditionN
	
	% rearrange order of data to display bars in correct order
	switch i
		case 1
			x=3;
		case 2
			x=1;
		case 3
			x=2;
	end
	
	res = resultsStructArray(x);
	
	maxGrad(1,i) = mean(res.maxGradTest);
	maxGrad(2,i) = mean(res.maxGradControl);
	
	errorGrad(1,i) = std(res.maxGradTest);
	errorGrad(2,i) = std(res.maxGradControl);
	
end

x = horzcat((1:2)' - 0.22,(1:2)',(1:2)' +0.22);

figure
b = bar(maxGrad);
hold on
errorbar(x,maxGrad,errorGrad,'.k')
legend('WT','F508del','F508del/R1070W','location','northeast')
xticklabels({'DMSO + Forskolin','DMSO'})
ylabel('Mean max. d [I^-] / dt  (mM s^{-1})')
% ylim([0 1.4])
b(1).FaceColor = colors(2,:);
b(2).FaceColor = colors(6,:);
b(3).FaceColor = colors(4,:);
set(gca,'fontsize',16)

end

