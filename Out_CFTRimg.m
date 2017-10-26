
saveLocalResultsHere    ='C:\Users\StellaPrins\Desktop\local_demo2.xls';
saveQuenchResultsHere   ='C:\Users\StellaPrins\Desktop\quench_demo.xls';

%%
colors = get(groot,'DefaultAxesColorOrder');

%% SET UP RESULTS STRUCT
resultsLocal = createResultsLocalStruct(cond);
for i=1:conditionN
	resultsLocal(i) = filterNegativeMetric(resultsLocal(i));
end

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
Ymem        = vertcat((horzcat(cellstr('Membrane density'), ...
              cellstr('std'))),num2cell([meanYFPMembrane; stdYFPMembrane]'));
horzcat(condition,N,Ymem)
xlswrite([saveLocalResultsHere],[condition,N,Ymem]);

%% QQ-PLOTS & FREQUENCY DISTRIBUTIONS (TO TEST NORMALITY) %%
for b  = 1:length(cond)
    MembraneDensity = resultsLocal(b).yelMembrane./resultsLocal(b).redEntire;
    subplot(ceil(sqrt((length(cond)/2))),round(sqrt((length(cond)*2))),b);
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
    subplot(ceil(sqrt((length(cond)/2))),round(sqrt((length(cond)*2))),b);
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
cellCount   = 1;

for i=1:conditionN
	res = resultsLocal(i);
	statsData(cellCount:(cellCount+res.localCellN-1)) = ...
    res.yelMembrane ./ res.redEntire;
	group(cellCount:(cellCount+res.localCellN-1)) = {res.mutation};
	cellCount = cellCount + res.localCellN;
end

[pKruskalWallis, statsKW] = plotKruskalWallis(statsData,group);
figure;
[c,m,~,gnames] = multcompare(statsKW,'CType','dunn-sidak');


%% CORRELATION PLOTS

close all

for i=1:ceil(length(resultsLocal)/2);
    subplot( ceil(sqrt((length(resultsLocal)/2)/1.5)),...
             ceil(sqrt((length(resultsLocal)/2)*1.5)), i)
	plotLocalRedYelCorr(resultsLocal(i),'entire');
end

figure;

for i=ceil(length(resultsLocal)/2):ceil(length(resultsLocal));
    k=i-((length(resultsLocal)/2)-1);
    subplot( ceil(sqrt((length(resultsLocal)/2)/1.5)),...
             ceil(sqrt((length(resultsLocal)/2)*1.5)), k);
	plotLocalRedYelCorr(resultsLocal(i),'entire');
end

%% IMAGE DISPLAY
close all

x=1; % condition
y=5; % image number

boundingBox1 = cond(x).imageLocal(y).boundingBox(3,:);
boundingBox2 = cond(x).imageLocal(y).boundingBox(1,:);
boundingBox3 = cond(x).imageLocal(y).boundingBox(3,:);
imgDisplayRectangle(cond(x).imageLocal(y),'red',boundingBox1,boundingBox2)

%% CELL DISPLAY
close all

x=1; % condition
y=4; % image number

for i=4:6 %cond(x).imageLocal(y).cellN(end)
	figure('position',[400 400 500 600])
	subplot(3,3,1)
	cellDisplay(cond(x).imageLocal(y),'red',i)
	subplot(3,3,2)
	cellDisplay(cond(x).imageLocal(y),'yel',i)
	subplot(3,3,3)
	cellDisplay(cond(x).imageLocal(y),'bw',i)
	subplot(3,1,[2,3],'position',[0.12 0.1 0.74 0.54])
	plotFOverDistance(cond(x).imageLocal(y),i)
end

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% QUENCHING OUTPUT

resultsQuench           = createResultsQuenchStruct(cond);
influx_rate             = zeros(1,conditionN);
influx_rate_std         = zeros(1,conditionN);
Quench_N                = zeros(1,conditionN);
influx_rate_DMSO        = zeros(1,conditionN);
influx_rate_DMSO_std    = zeros(1,conditionN);
Quench_DMSO_N           = zeros(1,conditionN);
influx_rate_t           = zeros(1,conditionN);
influx_rate_t_std       = zeros(1,conditionN);
influx_rate_DMSO_t      = zeros(1,conditionN);
influx_rate_DMSO_t_std  = zeros(1,conditionN);

for i = 1:conditionN
	res                     = resultsQuench(i);
    %FORSKOLIN
    Quench_N(i)             = length(res.maxGradTest);
    influx_rate(i)          = mean(res.maxGradTest);
    influx_rate_std(i)      = std(res.maxGradTest);
    influx_rate_t(i)        = mean(res.maxGradTestLoc);
    influx_rate_t_std(i)    = std(res.maxGradTestLoc);
    %DMSO CONTROL
    Quench_DMSO_N(i)        = length(res.maxGradControl);
    influx_rate_DMSO(i)     = mean(res.maxGradControl);
    influx_rate_DMSO_std(i) = std(res.maxGradControl);
    influx_rate_DMSO_t(i)   = mean(res.maxGradControlLoc);
    influx_rate_DMSO_t_std(i)= std(res.maxGradControlLoc);
end

condition_quench  = vertcat(cellstr('condition'),cellstr({resultsQuench.mutation}'));
N_quench_F        = vertcat(cellstr('N'),num2cell([Quench_N]'));
max_rate_F        = vertcat((horzcat(cellstr('max rate I entry (F)'), ...
                    cellstr('std'))),num2cell([influx_rate; influx_rate_std]'));
max_rate_F_tp     = vertcat((horzcat(cellstr('timepoint at max rate I entry (F)'), ...
                    cellstr('std'))),num2cell([influx_rate_t; influx_rate_t_std]'))       
N_quench_DMSO     = vertcat(cellstr('N'),num2cell([Quench_DMSO_N]'));
max_rate_DMSO     = vertcat((horzcat(cellstr('max rate I entry (DMSO)'), ...
                    cellstr('std'))),num2cell([influx_rate_DMSO; influx_rate_DMSO_std]'));
max_rate_DMSO_tp  = vertcat((horzcat(cellstr('timepoint at max rate I entry (DMSO)'), ...
                    cellstr('std'))),num2cell([influx_rate_DMSO_t; influx_rate_DMSO_t_std]'))
           
horzcat     (condition_quench,N_quench_F,max_rate_F,max_rate_F_tp,...
             N_quench_DMSO,max_rate_DMSO,max_rate_DMSO_tp)
xlswrite    ([saveQuenchResultsHere],...
            [condition_quench,N_quench_F,max_rate_F,max_rate_F_tp,...
            N_quench_DMSO,max_rate_DMSO,max_rate_DMSO_tp]);
%         
%  % TIMELINE
% for k = 1:conditionN
%     quenching_timeline(cond(k));
%     results_quenching_timeline(k,:) = ;
%    subplot(ceil(sqrt(conditionN)),ceil(sqrt(conditionN)),i)
% end

%% QUENCHING PLOTS 
close all
ymin = zeros(conditionN,1);
ymax = zeros(conditionN,1);

for i=1:conditionN
	ymin(i) = min(vertcat(cond(i).imageQuench.yelInsideOverT));
	ymax(i) = max(vertcat(cond(i).imageQuench.yelInsideOverT));
end

figure;
for i=1:conditionN
   subplot(ceil(sqrt(conditionN)),ceil(sqrt(conditionN)),i)
   plotYelOverTimeCollated(cond(i))
end

plotMaxGradBarChart(resultsQuench)

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
[p,h,stats] = ranksum(resultsQuench(2).maxGradTest,resultsQuench(2).maxGradControl);
[p,h,stats] = ranksum(resultsQuench(3).maxGradTest,resultsQuench(3).maxGradControl);


