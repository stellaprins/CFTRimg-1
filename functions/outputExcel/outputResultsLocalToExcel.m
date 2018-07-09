function outputResultsLocalToExcel( resultsStructArray , saveLocationFolder )
%OUTPUT_RESULTS_LOCAL_TO_EXCEL
%   The 'xlswrite' function only works on Windows machines and the
%   'writetable' function only works on Mac machine. This function splits
%   so to work on both PC an unix machines.
%
%		This function creates two csv files. The first gives all for every
%		cell. The second csv file gives a summary of the most relevant
%		statistics.

conditionN = length(resultsStructArray);

% create table of full results

totalCellN = 0;
for i=1:conditionN
	resultsStruct = resultsStructArray(i);
	totalCellN = totalCellN + resultsStruct.localCellN;
end

expStr							= cell(totalCellN,1);
plateIdx						= cell(totalCellN,1);
condition						= cell(totalCellN,1);
normCondition				= cell(totalCellN,1);
yelMembrane					= cell(totalCellN,1);
yelEntire						= cell(totalCellN,1);
redEntire						= cell(totalCellN,1);
yelMembraneAbsolute	= cell(totalCellN,1);
yelEntireAbsolute		= cell(totalCellN,1);
redEntireAbsolute		= cell(totalCellN,1);
memDens							= cell(totalCellN,1);
logMemDens					= cell(totalCellN,1);

cntr = 1;
for j=1:conditionN
	resultsStruct = resultsStructArray(j);
	localCellN = resultsStruct.localCellN;
	
	expStr(cntr:cntr+localCellN-1) = resultsStruct.cellLocation(:,1);
	plateIdx(cntr:cntr+localCellN-1) = resultsStruct.cellLocation(:,2);
	condition(cntr:cntr+localCellN-1) = {resultsStruct.condition};
	normCondition(cntr:cntr+localCellN-1) = {resultsStruct.normCondition};
	yelMembrane(cntr:cntr+localCellN-1) = num2cell(resultsStruct.yelMembrane(:));
	yelEntire(cntr:cntr+localCellN-1) = num2cell(resultsStruct.yelEntire(:));
	redEntire(cntr:cntr+localCellN-1) = num2cell(resultsStruct.redEntire(:));
	yelMembraneAbsolute(cntr:cntr+localCellN-1) = num2cell(resultsStruct.yelMembraneAbsolute(:));
	yelEntireAbsolute(cntr:cntr+localCellN-1) = num2cell(resultsStruct.yelEntireAbsolute(:));
	redEntireAbsolute(cntr:cntr+localCellN-1) = num2cell(resultsStruct.redEntireAbsolute(:));
	memDens(cntr:cntr+localCellN-1) = num2cell(resultsStruct.memDens(:));
	logMemDens(cntr:cntr+localCellN-1) = num2cell(resultsStruct.logMemDens(:));
	
	cntr = cntr + localCellN;
end

fullResults = horzcat(expStr,plateIdx,condition,normCondition,yelMembrane...
	,yelEntire,redEntire,yelMembraneAbsolute,yelEntireAbsolute...
	,redEntireAbsolute,memDens,logMemDens);
fullHeader = {'expStr', 'plateIdx', 'condition', 'normCondition'...
	, 'yelMembrane', 'yelEntire', 'redEntire', 'yelMembraneAbsolute'...
	, 'yelEntireAbsolute', 'redEntireAbsolute', 'memDens', 'logMemDens'};

fullCellArray = vertcat(fullHeader,fullResults);
fullTable = cell2table(fullResults,'VariableNames',fullHeader);

dateFormat = 'yyyy_mm_dd_HHMM';
dateStr = datestr(now,dateFormat); 

if exist(saveLocationFolder,'dir') ~= 7
	mkdir(saveLocationFolder)
end

if ispc == true
	fullFileName = strcat('fullLocalResults_',dateStr,'.xlsx');
	xlswrite(fullfile(saveLocationFolder,fullFileName),fullCellArray)
elseif isunix == true
	fullFileName = strcat('fullLocalResults_',dateStr,'.csv');
	writetable(fullTable,fullfile(saveLocationFolder,fullFileName))
end

disp('Finished writing to file')


% create summary table





% meanYFPMembrane   = zeros(1,conditionN);
% stdYFPMembrane		= zeros(1,conditionN);
% medianYFPMembrane	= zeros(1,conditionN);
% iqrYFPMembrane    = zeros(1,conditionN);
% 
% for i=1:conditionN
% 	
% 	res = resultsStructArray(i);
% 	meanYFPMembrane(i)		= mean(res.yelMembrane ./ res.redEntire);
% 	stdYFPMembrane(i)			= std(res.yelMembrane ./ res.redEntire);
%  	medianYFPMembrane(i)	= median(res.yelMembrane ./ res.redEntire);
% 	iqrYFPMembrane(i)			= iqr(res.yelMembrane ./ res.redEntire);
% 	
% end
% 
% conditions	= {resultsStructArray.mutation}';
% cellN       = [resultsStructArray.localCellN]';
% meanYFPMem	= meanYFPMembrane';
% stdYFPMem		= stdYFPMembrane';
% 
% T = table(conditions,cellN,meanYFPMem,stdYFPMem...
% 	,'VariableNames',{'condition','N','Membrane_density','std'});
% 
% writetable(T,saveLocationFolder)


end

