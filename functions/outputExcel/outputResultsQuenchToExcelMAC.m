function outputResultsQuenchToExcelMAC( resultsStructArray , saveLocationPath )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

conditionN = length(resultsStructArray);

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
		res                     = resultsStructArray(i);
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

condition_quench  = vertcat(cellstr({resultsStructArray.condition}'));
N_quench_F        = vertcat(num2cell([Quench_N]'));
max_rate_F        = vertcat(num2cell([influx_rate; influx_rate_std]'));
max_rate_F_tp     = vertcat(num2cell([influx_rate_t; influx_rate_t_std]'));
N_quench_DMSO     = vertcat(num2cell([Quench_DMSO_N]'));
max_rate_DMSO     = vertcat(num2cell([influx_rate_DMSO; influx_rate_DMSO_std]'));
max_rate_DMSO_tp  = vertcat(num2cell([influx_rate_DMSO_t; influx_rate_DMSO_t_std]'));

horzcat     (condition_quench,N_quench_F,max_rate_F,max_rate_F_tp,...
						 N_quench_DMSO,max_rate_DMSO,max_rate_DMSO_tp)
					

T = table(condition_quench,N_quench_F,max_rate_F,max_rate_F_tp,...
						 N_quench_DMSO,max_rate_DMSO,max_rate_DMSO_tp...
	,'VariableNames',{'condition','N_forskolin','max_rate_forskolin'...
	'max_rate_F_tp','N_quench_DMSO','max_rate_DMSO','max_rate_DMSO_tp'});

writetable(T,saveLocationPath)


end