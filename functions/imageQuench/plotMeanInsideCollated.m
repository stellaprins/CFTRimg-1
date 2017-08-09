function plotMeanInsideCollated( conditionStruct )
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here


meanYel = horzcat(conditionStruct.imageQuench.yelInsideOverT);

% FIX ME
x=1:70;

meanYelTest = mean(meanYel(:,1:12),2);
meanYelControl = mean(meanYel(:,13:24),2);

errYelTest = std(meanYel(:,1:12),0,2);
errYelControl = std(meanYel(:,13:24),0,2);



shadedErrorBar(x,meanYelTest,errYelTest...
	,'lineprops','-r','transparent',1);
hold on;
shadedErrorBar(x,meanYelControl,errYelControl...
	,'lineprops','-b','transparent',1);
p1 = plot(nan,nan,'-r');
p2 = plot(nan,nan,'-b');
plot([4.5 5],[0 1.3],':k')
plot([24.5 24.5],[0 1.3],':k')
ylim([0 1.3])
xlim([0 70])
title(conditionStruct.mutation)
xlabel('Time point')
ylabel(sprintf('Norm. mean YFP signal\nwithin cells'))

legend([p1 p2],'test','control','location','southeast')

set(gca,'fontsize',16)






end

