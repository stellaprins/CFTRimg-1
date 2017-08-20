
colors = get(groot,'DefaultAxesColorOrder');
% colors(1,:) --> blue
% colors(2,:) --> red
% colors(3,:) --> yellow
% colors(4,:) --> purple
% colors(5,:) --> green
% colors(6,:) --> cyan
% colors(7,:) --> brown?

%% BOXPLOTS
% 
% image = zeros(2160*BINNING, 2160*BINNING, 5);
% imageData = zeros(2160^2 * BINNING^2,5);
% 
% for i = 1:5
% 	image(:,:,i) = im2double(imread(cond(1).imageLocal(10+i).redPath));
% 	tmp = image(:,:,i);
%  	imageData(:,i) = tmp(:);
% end
% 
% boxplot(imageData)


%% SET UP RESULTS STRUCT

resultsLocal = createResultsLocalStruct(cond3);

for i=1:conditionN

		resultsLocal(i) = filterNegativeMetric(resultsLocal(i));
		
end


%% LOCALISATION OUTPUT

meanYFPEntire		= zeros(1,conditionN);
meanYFPMembrane = zeros(1,conditionN);
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
%disp([meanYFPEntire; stdYFPEntire])
disp([meanYFPMembrane; stdYFPMembrane])
% disp([medianYFPMembrane; iqrYFPMembrane])
disp([resultsLocal.localCellN])


%% TESTS FOR NORMALITY

close all

for i=1:conditionN
	plotTestForNormality(resultsLocal(i));
end




%% TEST DIFFERENCE IN MCHERRY

close all

for i=1:conditionN
	plotRedHistogram(resultsLocal(i));
end

cellN = sum(vertcat(resultsLocal.localCellN));

redStatsData = zeros(cellN,1);
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
	
	redStatsData(cellCount:(cellCount+res.localCellN-1)) = res.redEntire;
	group(cellCount:(cellCount+res.localCellN-1)) = {res.mutation};
	
	cellCount = cellCount + res.localCellN;
	
end

[pRedKW, statsRedKW] = plotKruskalWallis(redStatsData,group);

figure
[cRed,mRed,~] = multcompare(statsRedKW,'CType','dunn-sidak');

h=zeros(3);
p=zeros(3);

for j=1:conditionN
	for i=1:conditionN
		
		r = resultsLocal;
		
		[h(i,j),p(i,j)] = kstest2(r(i).redEntire,r(j).redEntire);
		
	end
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

for i=1:length(cond3)
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


x=1;
y=6;


cond(x).imageLocal(y).cellN

[maxGrad, maxGradLoc,refGrad] = findGradient(cond(x).imageLocal(y));

for i=1:cond(x).imageLocal(y).cellN(end)
	
	str1 = sprintf('max %g\nloc %g\n\nref %g'...
		,round(maxGrad(i),5)...
		,maxGradLoc(i)...
		,round(refGrad(i),5));
	
	str2 = sprintf('membrane %g\nentire %g'...
		,round(cond(x).imageLocal(y).yelMembrane(i)/cond(x).imageLocal(y).redEntire(i),3)...
		,round(cond(x).imageLocal(y).yelEntire(i)/cond(x).imageLocal(y).redEntire(i),3));
	
	dim1 = [.15 .65 .1 .1];
	dim2 = [.45 .65 .1 .1];
	
	figure
	subplot(5,3,1)
	cellDisplay(cond(x).imageLocal(y),'red',i)
	subplot(5,3,2)
	cellDisplay(cond(x).imageLocal(y),'yel',i)
	subplot(5,3,3)
	cellDisplay(cond(x).imageLocal(y),'bw',i)
	annotation('textbox',dim1,'String',str1,'FitBoxToText','on');
	annotation('textbox',dim2,'String',str2,'FitBoxToText','on');
	subplot(5,3,6)
	cellDisplay(cond(x).imageLocal(y),'overlay',i)
	subplot(5,1,[3,4,5],'fontsize',14)
	plotFOverDistance(cond(x).imageLocal(y),i)
	
end



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

% figure
% for i=1:conditionN
%     subplot(1,3,i)
%     plotYelOverTimeCollated(cond(i))
% end


for i=1:conditionN
    figure
    plotYelOverTimeCollated(cond(i))
end