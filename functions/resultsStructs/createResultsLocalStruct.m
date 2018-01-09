function resultsStructArray = createResultsLocalStruct( normStructArray )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

plateN = length(normStructArray);

% create cell array of mutations across all plates
conditions = cell(0,1);
for i=1:plateN
	conditions = unique(vertcat(conditions,normStructArray(i).mutation));
end

conditions = conditions';
conditionN = length(conditions);

resultsTemplate = struct(...
			'mutation',''...
			,'cellLocation',[]...
			,'yelEntire',[]...
			,'yelMembrane',[]...
			,'redEntire',[]...
			,'localCellN',[]);
		
% find out how many cells per condition across all plates
cellsPerConditionPlate = zeros(plateN,conditionN);
for j=1:conditionN
	currentCondition = conditions{j};
	for i=1:plateN
		compareCondition = strcmp(currentCondition,normStructArray(i).mutation);
		cellsPerConditionPlate(i,j) = sum(compareCondition);
	end
end

% fill results structs with empty arrays
for i=1:conditionN
	
	resultsStructArray(i) = resultsTemplate;
	resultsStructArray(i).mutation = conditions{i};
	
	cellN = sum(cellsPerConditionPlate(:,i));
	resultsStructArray(i).localCellN = cellN;
	
	resultsStructArray(i).cellLocation	= zeros(cellN,3);
	resultsStructArray(i).yelEntire			= zeros(cellN,1);
	resultsStructArray(i).yelMembrane		= zeros(cellN,1);
	resultsStructArray(i).redEntire			= zeros(cellN,1);
	
	
end
	
end