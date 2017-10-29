function resultsStructArray = createResultsLocalStruct( plateStructArray )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

plateN = length(plateStructArray);

% create cell array of mutations across all plates
conditions = cell(0,1);
for i=1:plateN
	conditions = unique(horzcat(conditions,{plateStructArray(i).imageLocal.mutation}));
end

conditionN = length(conditions);


resultsTemplate = struct(...
			'mutation',''...
			,'yelEntire',[]...
			,'yelMembrane',[]...
			,'redEntire',[]...
			,'localCellN',[]);
		
for i=1:conditionN
	resultsStructArray(i) = resultsTemplate;
	resultsStructArray(i).mutation = conditions{i};
end
	
end