
saveLocalResultsHere='C:\Users\StellaPrins\Documents\results30082017.xls';

%%
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

% resultsLocal = normalizeResultsWT(resultsLocal);


%% LOCALISATION OUTPUT

meanYFPEntire		= zeros(1,conditionN);
meanYFPMembrane     = zeros(1,conditionN);
stdYFPEntire		= zeros(1,conditionN);
stdYFPMembrane      = zeros(1,conditionN);
medianYFPMembrane   = zeros(1,conditionN);
iqrYFPMembrane      = zeros(1,conditionN);

meanRedEntire       = zeros(1,conditionN);
stdRedEntire		= zeros(1,conditionN);

for i=1:conditionN

	res = resultsLocal(i);
	
	meanYFPEntire(i)		= mean(res.yelEntire ./ res.redEntire);
	stdYFPEntire(i)			= std(res.yelEntire ./ res.redEntire);
	meanYFPMembrane(i)	    = mean(res.yelMembrane ./ res.redEntire);
	stdYFPMembrane(i)		= std(res.yelMembrane ./ res.redEntire);
 	medianYFPMembrane(i)	= median(res.yelMembrane ./ res.redEntire);
 	iqrYFPMembrane(i)		= iqr(res.yelMembrane ./ res.redEntire);
	
	meanRedEntire(i)        = mean(res.redEntire);
	stdRedEntire(i)         = std(res.redEntire);


end
condition   = vertcat(cellstr('condition'),cellstr({resultsLocal.mutation}'));
N           = vertcat(cellstr('N'),num2cell([resultsLocal.localCellN]'));
Ymem        = vertcat((horzcat(cellstr('Membrane density'), cellstr('std'))),num2cell([meanYFPMembrane; stdYFPMembrane]'));

horzcat(condition,N,Ymem)

xlswrite([saveLocalResultsHere],[condition,N,Ymem]);

% ([meanRedEntire; stdRedEntire]')
% disp([meanYFPEntire; stdYFPEntire])
% disp([meanYFPMembrane; stdYFPMembrane])
% disp([medianYFPMembrane; iqrYFPMembrane])


%% TESTS FOR NORMALITY

% close all
% 
% for i=1:conditionN
% 	plotTestForNormality(resultsLocal(i));
% end

for b  = 1:length(cond)
    MembraneDensity = resultsLocal(b).yelMembrane./resultsLocal(b).redEntire;
    subplot(round(sqrt((length(cond)/2))),round(sqrt((length(cond)*2))),b);
    qqplot(MembraneDensity);
    yLab = ylabel(sprintf('F_{YFP,membrane} / F_{mCh,cell}\nQuantiles'));
	set(yLab,'fontsize',9)
    xLab = xlabel(sprintf('Standard Normal Quantiles'));
    set(xLab,'fontsize',8)
    title(cond(b).mutation);
end

figure;

for b  = 1:length(cond)
    MembraneDensity = resultsLocal(b).yelMembrane./resultsLocal(b).redEntire;
    subplot(round(sqrt((length(cond)/2))),round(sqrt((length(cond)*2))),b);
    hist(MembraneDensity);
    xLab = xlabel('F_{YFP,membrane} / F_{mCh,cell}');
	set(xLab,'fontsize',9)
	yLab = ylabel('Frequency');
	set(yLab,'fontsize',8)
    title(cond(b).mutation);
end

%% STATISTICS

close all

cellN       = sum(vertcat(resultsLocal.localCellN));
statsData   = zeros(cellN,1);
group       = cell(cellN,1);

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

close all

for i=1:length(resultsLocal)
	figure
	plotLocalRedYelCorr(resultsLocal(i),'entire')
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

x=4;
y=1;

% cond(x).imageLocal(y).cellN

% [maxGrad, maxGradLoc,refGrad] = findGradient(cond1(x).imageLocal(y));

for i=1:cond(x).imageLocal(y).cellN(end)
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
	
	cellDisplay(cond(x).imageLocal(y),'red',i)
	subplot(3,3,2)
	cellDisplay(cond(x).imageLocal(y),'yel',i)
	subplot(3,3,3)
	cellDisplay(cond(x).imageLocal(y),'bw',i)
% 	annotation('textbox',dim1,'String',str1,'FitBoxToText','on');
% 	annotation('textbox',dim2,'String',str2,'FitBoxToText','on');
% 	subplot(5,3,6)
% 	cellDisplay(cond1(x).imageLocal(y),'overlay',i)
	subplot(3,1,[2,3],'position',[0.12 0.1 0.74 0.54])
	plotFOverDistance(cond(x).imageLocal(y),i)
	
end


%% IMAGE DISPLAY

boundingBox1 = cond(x).imageLocal(y).boundingBox(3,:);
boundingBox2 = cond(x).imageLocal(y).boundingBox(1,:);
imgDisplayRectangle(cond(x).imageLocal(y),'red',boundingBox1,boundingBox2)


%% QUENCHING OUTPUT

resultsQuench = createResultsQuenchStruct(cond);

for i=1:conditionN
	
	res = resultsQuench(i);
	
	fprintf('\n%s - Test\n',res.mutation)
	disp([mean(res.maxGradTest),std(res.maxGradTest)])
	disp([mean(res.maxGradTestLoc),std(res.maxGradTestLoc)])
	
	fprintf('%s - Control\n',res.mutation)
	disp([mean(res.maxGradControl),std(res.maxGradControl)])
	disp([mean(res.maxGradControlLoc),std(res.maxGradControlLoc)])
		
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
% for i=1:25
%     subplot(5,5,i)
%     plotYelOverTimeCollated(cond(i))
% end
% 
% figure
% for i=26:conditionN
%     k = i-25;
%     subplot(5,5,k)
% end

for i=1:conditionN
   figure
   plotYelOverTimeCollated(cond(i))
end


plotMaxGradBarChart( resultsQuench )


%% TESTS FOR NORMALITY

for i=1:conditionN
	plotTestForNormalityQuench(resultsQuench(i));
end

%% STATISTICS

close all

statsDataQuench = horzcat(resultsQuench.maxGradTest);

[pKWQuench,tblKWQuench,statsKWQuench] = kruskalwallis(statsDataQuench)

figure
[cQuench,mQuench] = multcompare(statsKWQuench,'CType','dunn-sidak');


[p,h,stats] = ranksum(resultsQuench(1).maxGradTest,resultsQuench(1).maxGradControl);
%p = 0.976970255321976
[p,h,stats] = ranksum(resultsQuench(2).maxGradTest,resultsQuench(2).maxGradControl);
%p = 3.658455353897101e-05
[p,h,stats] = ranksum(resultsQuench(3).maxGradTest,resultsQuench(3).maxGradControl);
%p = 3.658455353897101e-05


