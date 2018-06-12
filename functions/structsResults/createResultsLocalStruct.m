function resultsStructArray = createResultsLocalStruct( normStructArray )
%CREATE_RESULTS_LOCAL_STRUCT Initialize empty results struct
%		Create struct to store all data after it has been normalized. The data
%		is now sorted by condition rather than by experiment.

normStructN = length(normStructArray);

% create cell array of normalize conditions
normConditions = cell(0,1);
for i=1:normStructN
	normConditions = unique(vertcat(normConditions,...
		normStructArray(i).normCondition));
end
normCondN = length(normConditions);

% create cell array of conditions across all experiments
conditions = cell(0,1);
for i=1:normStructN
	conditions = unique(vertcat(conditions,normStructArray(i).condition));
end
conditions = conditions';
conditionN = length(conditions);

resultsTemplate = struct(...
			'condition',''...
			,'normCondition',''...
			,'cellLocation',{{}}...
			,'yelMembrane',[]...
			,'yelEntire',[]...
			,'redEntire',[]...
			,'yelMembraneAbsolute',[]...
			,'yelEntireAbsolute',[]...
			,'redEntireAbsolute',[]...
			,'memDens',[]...
			,'logMemDens',[]...
			,'localCellN',[]);
		
% find out how many cells per condition/normCondition across all
% experiments
cellsPerConditionExp = zeros(normCondN,conditionN);
for k=1:conditionN
	currentCond = conditions{k};
	for j=1:normCondN
		currentNormCond = normConditions{j};
		for i=1:normStructN
			compareCond = strcmp(currentCond,normStructArray(i).condition) & ...
				strcmp(currentNormCond,normStructArray(i).normCondition);
			cellsPerConditionExp(j,k) = cellsPerConditionExp(j,k) + sum(compareCond);
		end
	end
end

% fill results structs with empty arrays
for j=1:normCondN
	currentNormCond = normConditions{j};
	for i=1:conditionN
		resultsStruct = resultsTemplate;
									
		resultsStruct.condition			= conditions{i};
		resultsStruct.normCondition	= currentNormCond;
		cellN												= cellsPerConditionExp(j,i);
		resultsStruct.localCellN		= cellN;

		resultsStruct.cellLocation				= cell(cellN,4);
		resultsStruct.yelMembrane					= zeros(cellN,1);
		resultsStruct.yelEntire						= zeros(cellN,1);
		resultsStruct.redEntire						= zeros(cellN,1);
		resultsStruct.yelMembraneAbsolute = zeros(cellN,1);
		resultsStruct.yelEntireAbsolute		= zeros(cellN,1);
		resultsStruct.redEntireAbsolute		= zeros(cellN,1);
		resultsStruct.memDens							= zeros(cellN,1);
		resultsStruct.logMemDens					= zeros(cellN,1);
		
		resultsStructArray((j-1)*conditionN + i) = resultsStruct;
	end
end
	
end
