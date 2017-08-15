function plotYelOverTimeCollated( conditionStruct )
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here

yelN = 70;

testN			= conditionStruct.quenchImageTestN;
controlN	= conditionStruct.quenchImageControlN;

yelTest					= zeros(yelN,testN);
yelControl			= zeros(yelN,testN);

countTest			= 1;
countControl	= 1;
for i=1:(testN+controlN)
	
	if strcmp(conditionStruct.imageQuench(i).test_control,'test')
		
		yelTest(:,countTest) = conditionStruct.imageQuench(i).yelInsideOverT;
		countTest = countTest + 1;
		
	elseif strcmp(conditionStruct.imageQuench(i).test_control,'control')
		
		yelControl(:,countControl) = conditionStruct.imageQuench(i).yelInsideOverT;
		countControl = countControl + 1;
		
	end
	
end
	
meanYelTest = mean(yelTest,2);
meanYelControl = mean(yelControl,2);
errYelTest = std(yelTest,0,2);
errYelControl = std(yelControl,0,2);

x=1:70;

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

