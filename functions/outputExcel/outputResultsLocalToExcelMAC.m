function outputResultsLocalToExcelMAC( resultsStructArray , saveLocationPath )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

conditionN = length(resultsStructArray);

meanYFPMembrane   = zeros(1,conditionN);
stdYFPMembrane		= zeros(1,conditionN);
medianYFPMembrane	= zeros(1,conditionN);
iqrYFPMembrane    = zeros(1,conditionN);

for i=1:conditionN
	
	res = resultsStructArray(i);
	meanYFPMembrane(i)		= mean(res.yelMembrane ./ res.redEntire);
	stdYFPMembrane(i)			= std(res.yelMembrane ./ res.redEntire);
 	medianYFPMembrane(i)	= median(res.yelMembrane ./ res.redEntire);
	iqrYFPMembrane(i)			= iqr(res.yelMembrane ./ res.redEntire);
	
end

conditions	= {resultsStructArray.mutation}';
cellN       = [resultsStructArray.localCellN]';
meanYFPMem	= meanYFPMembrane';
stdYFPMem		= stdYFPMembrane';

T = table(conditions,cellN,meanYFPMem,stdYFPMem...
	,'VariableNames',{'condition','N','Membrane_density','std'});

writetable(T,saveLocationPath)


end

