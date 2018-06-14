
saveQuenchResultsHere       = fullfile('~','Desktop','resultsQuench');
saveQuenchingTimelineHere   = fullfile('~','Desktop','timelineQuench');
%%
conditionN = length(resultsQuench);

%% QUENCHING OUTPUT 1

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

if ispc == true

	condition_quench  = vertcat(cellstr('condition'),cellstr({resultsQuench.mutation}'));
	N_quench_F        = vertcat(cellstr('N'),num2cell([Quench_N]'));
	max_rate_F        = vertcat((horzcat(cellstr('max rate I entry (F)'), ...
											cellstr('std'))),num2cell([influx_rate; influx_rate_std]'));
	max_rate_F_tp     = vertcat((horzcat(cellstr('timepoint at max rate I entry (F)'), ...
											cellstr('std'))),num2cell([influx_rate_t; influx_rate_t_std]'));
	N_quench_DMSO     = vertcat(cellstr('N'),num2cell([Quench_DMSO_N]'));
	max_rate_DMSO     = vertcat((horzcat(cellstr('max rate I entry (DMSO)'), ...
											cellstr('std'))),num2cell([influx_rate_DMSO; influx_rate_DMSO_std]'));
	max_rate_DMSO_tp  = vertcat((horzcat(cellstr('timepoint at max rate I entry (DMSO)'), ...
											cellstr('std'))),num2cell([influx_rate_DMSO_t; influx_rate_DMSO_t_std]'));

	horzcat     (condition_quench,N_quench_F,max_rate_F,max_rate_F_tp,...
							 N_quench_DMSO,max_rate_DMSO,max_rate_DMSO_tp);
	xlswrite    (saveQuenchResultsHere,...
							[condition_quench,N_quench_F,max_rate_F,max_rate_F_tp,...
							N_quench_DMSO,max_rate_DMSO,max_rate_DMSO_tp]);
						
elseif isunix == 1
	
	outputResultsQuenchToExcelMAC( resultsQuench , saveQuenchResultsHere );
	
end
	        
%% QUENCHING OUTPUT 2 (TIMELINE)

if ispc == true
	
	count_col1   = 0;
	for i = 1:conditionN
		count_F     = length(resultsQuench(i).maxGradTest);
		count_DMSO  = length(resultsQuench(i).maxGradControl);
		count_col1  = count_col1 + count_F*2+count_DMSO*2+8;
	end

	l      = vertcat(resultsQuench(1).yelInsideOverTTest...
		,resultsQuench(1).yelInsideOverTControl);
	l      = length(l)+2;
	space  = cell(l,count_col1);
	count_col2                   = zeros(1,conditionN);
	for i = 1:conditionN
		results_quenching_timeline  = quenching_timeline(resultsQuench(i));
		count_F                     = length(resultsQuench(i).maxGradTest);
		count_DMSO                  = length(resultsQuench(i).maxGradControl);
		count_col2(1,i)             = count_F*2+count_DMSO*2+8;
		space(:,1+sum(count_col2(1:i-1)):sum(count_col2(1:i)))=results_quenching_timeline;
	end

	xlswrite([saveQuenchingTimelineHere], [space]);
	
elseif isunix == true
	
	outputQuenchTimelineToExcelMAC(resultsQuench,saveQuenchingTimelineHere);
	
end


%% QUENCHING PLOTS 
close all
figure;

for i=1:conditionN
	  subplot(4,ceil(conditionN/2),i);
		plotYelOverTimeCollated(resultsQuench(i));
		subplot(4,ceil(conditionN/2),i+conditionN);
		plotYelOverTime(resultsQuench(i));
end


% figure
% plotMaxGradBarChart(resultsQuench) %% not working

%% TESTS FOR NORMALITY
% for i=1:conditionN
% 	plotTestForNormalityQuench(resultsQuench(i));
% end

%% STATISTICS
close all

count1	 = 1;
for i=1:conditionN
	for k					= count1: (count1+length(resultsQuench(i).maxGradTest)-1);
	groupQ_FORS(k)	= {resultsQuench(i).condition};
	end
	count1					= count1 + length(resultsQuench(i).maxGradTest);
end
groupQ_FORS			= 	groupQ_FORS';
statsDataQuench = vertcat(resultsQuench.maxGradTest);

[pKWQuench,tblKWQuench,statsKWQuench] = kruskalwallis(statsDataQuench,groupQ_FORS);

% plotKruskalWallisQuench(statsDataQuench,groupQ_FORS);

figure
[cQuench,mQuench] = multcompare(statsKWQuench,'CType','bonferroni');

for i = 1: conditionN
[h,p,ci,stats] = ttest2(resultsQuench(i).maxGradTest,resultsQuench(i).maxGradControl);
cond(i)     = {resultsQuench(i).condition};
p_Quench(i) = p;
% rank_Quench(i)= stats.ranksum;
end

% [h,p,ci,stats] = ttest2(x,y)
% [p,h,stats] = ranksum(resultsQuench(1).maxGradTest,resultsQuench(1).maxGradControl);
% [p,h,stats] = ranksum(resultsQuench(2).maxGradTest,resultsQuench(2).maxGradControl);
% [p,h,stats] = ranksum(resultsQuench(3).maxGradTest,resultsQuench(3).maxGradControl);