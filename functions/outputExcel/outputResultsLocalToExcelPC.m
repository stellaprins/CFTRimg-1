function outputResultsLocalToExcelPC( resultsStructArray , saveLocationPath )
%OUTPUT_RESULTS_LOCAL_TO_EXCEL_PC
%   The 'xlswrite' function only works on Windows machines and the
%   'writetable' function only works on Mac machine. Two functions have
%   been created to circumvent this issue.

meanYFPMembrane   = zeros(1,conditionN);
stdYFPMembrane		= zeros(1,conditionN);
medianYFPMembrane	= zeros(1,conditionN);

for i=1:conditionN
	res										= resultsStructArray(i);
	meanYFPMembrane(i)		= mean(res.yelMembrane ./ res.redEntire);
	stdYFPMembrane(i)			= std(res.yelMembrane ./ res.redEntire);
	medianYFPMembrane(i)	= median(res.yelMembrane ./ res.redEntire);
	iqrYFPMembrane(i)			= iqr(res.yelMembrane ./ res.redEntire);
end

condition   = vertcat({'condition'},{resultsLocal.mutation}');
N           = vertcat({'N'},{resultsLocal.localCellN}');
Ymem        = vertcat(horzcat({'mean membrane density'},{'median membrane density'},{'std'})...
	,num2cell([meanYFPMembrane; medianYFPMembrane; stdYFPMembrane]'));
results			=	horzcat(condition,N,Ymem);

xlswrite(saveLocationPath,results)
	
end

