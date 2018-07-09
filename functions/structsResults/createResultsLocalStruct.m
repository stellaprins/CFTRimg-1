function resultsStructArray = createResultsLocalStruct( normStructArray )
%CREATE_RESULTS_LOCAL_STRUCT Initialize empty results struct
%		Create struct to store all data after it has been normalized. The data
%		is now sorted by condition rather than by experiment.

normStructN = length(normStructArray);

% create cell array of {condition norm normCondition) across all experiments
fullConditions		= cell(0,1);
for j=1:normStructN
	normStruct = normStructArray(j);
	tmpConditionN = length(normStruct.condition);
	clear tmpFullCondition
	tmpFullConditions = normStruct.condition;
	for i=1:tmpConditionN
		tmpFullConditions(i) = strcat(normStruct.condition(i),{' norm '},normStruct.normCondition);
	end
	fullConditions = unique(vertcat(fullConditions,tmpFullConditions));
end
fullConditions = fullConditions';
fullConditionN = length(fullConditions);

fullConditionsSplit = cell(fullConditionN,2);
for i=1:fullConditionN
	newStr = split(fullConditions{i},' norm ');
	fullConditionsSplit{i,1} = char(newStr(1));
	fullConditionsSplit{i,2} = char(newStr(2));
end

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
cellsPerFullConditionExp	= zeros(fullConditionN);
expPerFullConditionExp		= zeros(fullConditionN);
for j=1:fullConditionN
	currentCond = fullConditionsSplit{j,1};
	currentNormCond = fullConditionsSplit{j,2};
	for i=1:normStructN
		compareCond = strcmp(currentCond,normStructArray(i).condition) & ...
			strcmp(currentNormCond,normStructArray(i).normCondition);
		cellsPerFullConditionExp(j) = cellsPerFullConditionExp(j) + sum(compareCond);
		if sum(compareCond) > 0
			expPerFullConditionExp(j)		= expPerFullConditionExp(j) + 1;
		end
	end
end

% fill results structs with empty arrays
for i=1:fullConditionN
	resultsStruct = resultsTemplate;

	resultsStruct.condition			= fullConditionsSplit{i,1};
	resultsStruct.normCondition	= fullConditionsSplit{i,2};
	cellN												= cellsPerFullConditionExp(i);
	resultsStruct.localCellN		= cellN;
% 	resultsStruct.expN					= expPerFullConditionExp(i);

	resultsStruct.cellLocation				= cell(cellN,4);
% 	resultsStruct.expStr							= cell(cellN,1);
	resultsStruct.yelMembrane					= zeros(cellN,1);
	resultsStruct.yelEntire						= zeros(cellN,1);
	resultsStruct.redEntire						= zeros(cellN,1);
	resultsStruct.yelMembraneAbsolute = zeros(cellN,1);
	resultsStruct.yelEntireAbsolute		= zeros(cellN,1);
	resultsStruct.redEntireAbsolute		= zeros(cellN,1);
	resultsStruct.memDens							= zeros(cellN,1);
	resultsStruct.logMemDens					= zeros(cellN,1);

	resultsStructArray(i) = resultsStruct;
end
	
end
