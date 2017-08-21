
colors = get(groot,'DefaultAxesColorOrder');
% colors(1,:) --> blue
% colors(2,:) --> red
% colors(3,:) --> yellow
% colors(4,:) --> purple
% colors(5,:) --> green
% colors(6,:) --> cyan
% colors(7,:) --> brown?

%% SET UP RESULTS STRUCT

resultsLocal = createResultsLocalStruct(cond);

for i=1:conditionN
	resultsLocal(i) = filterNegativeMetric(resultsLocal(i));
end

resultsLocal = normalizeResultsWT(resultsLocal);


%% LOCALISATION OUTPUT

meanYFPEntire		= zeros(1,conditionN);
meanYFPMembrane     = zeros(1,conditionN);
stdYFPEntire		= zeros(1,conditionN);
stdYFPMembrane = zeros(1,conditionN);
medianYFPMembrane = zeros(1,conditionN);
iqrYFPMembrane = zeros(1,conditionN);

for i=1:conditionN

	res = resultsLocal(i);
	
	meanYFPEntire(i)		= mean(res.yelEntire ./ res.redEntire);
	stdYFPEntire(i)			= std(res.yelEntire ./ res.redEntire);
	meanYFPMembrane(i)	= mean(res.yelMembrane ./ res.redEntire);
	stdYFPMembrane(i)		= std(res.yelMembrane ./ res.redEntire);
 	medianYFPMembrane(i)	= median(res.yelMembrane ./ res.redEntire);
 	iqrYFPMembrane(i)			= iqr(res.yelMembrane ./ res.redEntire);

end

disp({resultsLocal.mutation})
% disp([meanYFPEntire; stdYFPEntire])
disp([meanYFPMembrane; stdYFPMembrane])
% disp([medianYFPMembrane; iqrYFPMembrane])
disp([resultsLocal.localCellN])


%% TESTS FOR NORMALITY

close all

for i=1:conditionN
	plotTestForNormality(resultsLocal(i));
end

%% STATISTICS

close all

cellN = sum(vertcat(resultsLocal.localCellN));

statsData = zeros(cellN,1);
group = cell(cellN,1);

cellCount = 1;
for i=1:conditionN
	
	% rearrange order of data to display box plots in correct order
	switch i
		case 1
			x=3;
		case 2
			x=1;
		case 3
			x=2;
	end
			
	res = resultsLocal(x);
	
	statsData(cellCount:(cellCount+res.localCellN-1)) = ...
		res.yelMembrane ./ res.redEntire;
	group(cellCount:(cellCount+res.localCellN-1)) = {res.mutation};
	
	cellCount = cellCount + res.localCellN;
	
end


[pKruskalWallis, statsKW] = plotKruskalWallis(statsData,group);

figure
[c,m,~,gnames] = multcompare(statsKW,'CType','dunn-sidak');


%% CORRELATION PLOTS

% close all

for i=1:length(cond)
	figure
	plotLocalRedYelCorr(resultsLocal(i),'membrane')
% 	figure
% 	plotLocalRedYelCorr(resultsLocal(i),'membrane')
end

% figure
% for i=1:length(cond)
% 	subplot(3,3,i)
% 	plotLocalRedYelCorr(cond(i),'entire')
% 	subplot(3,3,i+3)
% 	plotLocalRedYelCorr(cond(i),'membrane')
% end

%% CELL DISPLAY

close all

x=10;
y=2;

% cond1(x).imageLocal(y).cellN

% [maxGrad, maxGradLoc,refGrad] = findGradient(cond1(x).imageLocal(y));

for i=1:cond1(x).imageLocal(y).cellN(end)
% for i=[9,18] % x=3, y=8
% for i=[3,17] % x=1, y=8
	
% 	str1 = sprintf('max %g\nloc %g\n\nref %g'...
% 		,round(maxGrad(i),5)...
% 		,maxGradLoc(i)...
% 		,round(refGrad(i),5));
% 	
% 	str2 = sprintf('membrane %g\nentire %g'...
% 		,round(cond1(x).imageLocal(y).yelMembrane(i)/cond1(x).imageLocal(y).redEntire(i),3)...
% 		,round(cond1(x).imageLocal(y).yelEntire(i)/cond1(x).imageLocal(y).redEntire(i),3));
% 	
% 	dim1 = [.15 .65 .1 .1];
% 	dim2 = [.45 .65 .1 .1];
	
	figure('position',[400 400 500 600])
	subplot(3,3,1)
	
	cellDisplay(cond1(x).imageLocal(y),'red',i)
	subplot(3,3,2)
	cellDisplay(cond1(x).imageLocal(y),'yel',i)
	subplot(3,3,3)
	cellDisplay(cond1(x).imageLocal(y),'bw',i)
% 	annotation('textbox',dim1,'String',str1,'FitBoxToText','on');
% 	annotation('textbox',dim2,'String',str2,'FitBoxToText','on');
% 	subplot(5,3,6)
% 	cellDisplay(cond1(x).imageLocal(y),'overlay',i)
	subplot(3,1,[2,3],'position',[0.12 0.1 0.74 0.54])
	plotFOverDistance(cond1(x).imageLocal(y),i)
	
end


%% IMAGE DISPLAY

boundingBox1 = cond1(x).imageLocal(y).boundingBox(3,:);
boundingBox2 = cond1(x).imageLocal(y).boundingBox(17,:);
imgDisplayRectangle(cond1(x).imageLocal(y),'red',boundingBox1,boundingBox2)


%% QUENCHING OUTPUT


for j=1:conditionN
	
	testLogical = zeros(length(cond(j).imageQuench),1);
	for i=1:length(cond(j).imageQuench)
		testLogical(i) = strcmp(cond(j).imageQuench(i).test_control,'test');
	end
	
	maxGradTest = zeros(sum(testLogical),1);
	maxGradControl = zeros(length(testLogical) - sum(testLogical),1);
	maxGradTestLoc = zeros(sum(testLogical),1);
	maxGradControlLoc = zeros(length(testLogical) - sum(testLogical),1.);
	
	maxGrad = vertcat(cond(j).imageQuench.maxGradIodine);
	maxGradLoc = vertcat(cond(j).imageQuench.maxGradLocation);
	
	counterTest = 1;
	counterControl = 1;
	for i=1:length(testLogical)
		if testLogical(i) == 1
			maxGradTest(counterTest) = maxGrad(i);
			maxGradTestLoc(counterTest) = maxGradLoc(i);
			counterTest = counterTest + 1;
		elseif testLogical(i) == 0
			maxGradControl(counterControl) = maxGrad(i);
			maxGradControlLoc(counterControl) = maxGradLoc(i);
			counterControl = counterControl + 1;
		end
	end
	
	fprintf('\n%s - Test\n',cond(j).mutation)
	disp([mean(maxGradTest),std(maxGradTest)])
	disp([mean(maxGradTestLoc),std(maxGradTestLoc)])
	
	fprintf('%s - Control\n',cond(j).mutation)
	disp([mean(maxGradControl),std(maxGradControl)])
	disp([mean(maxGradControlLoc),std(maxGradControlLoc)])
	
	
%  	disp([maxGradTest,maxGradTestLoc,maxGradControl,maxGradControlLoc])

	
end


%% QUENCHING PLOTS

close all

ymin = zeros(conditionN,1);
ymax = zeros(conditionN,1);
for i=1:conditionN
	ymin(i) = min(vertcat(cond(i).imageQuench.yelInsideOverT));
	ymax(i) = max(vertcat(cond(i).imageQuench.yelInsideOverT));
end

% disp([min(ymin), max(ymax)])

% m=4;
% 
% figure
% subplot(1,3,1)
% plotYelOverTime(cond(1),m)
% subplot(1,3,2)
% plotYelOverTime(cond(2),m)
% subplot(1,3,3)
% plotYelOverTime(cond(3),m)


figure
for i=1:25
    subplot(5,5,i)
    plotYelOverTimeCollated(cond(i))
end

figure
for i=26:conditionN
    k = i-25;
    subplot(5,5,k)
end

% for i=1:conditionN
%    figure
%    plotYelOverTimeCollated(cond(i))
%end