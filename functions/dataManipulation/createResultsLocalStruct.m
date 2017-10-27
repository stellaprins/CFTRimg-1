function resultsStructArray = createResultsLocalStruct( conditionStructArray )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

conditionN = length(conditionStructArray);
resultsTemplate = struct(...
			'mutation',[]...
			,'yelEntire',[]...
			,'yelMembrane',[]...
			,'redEntire',[]...
			,'localCellN',[]);
		
for i=1:conditionN
	resultsStructArray(i) = resultsTemplate;
end

for i=1:conditionN
	
	condStruct = conditionStructArray(i);
	
	resultsStructArray(i).mutation = condStruct.mutation;
	resultsStructArray(i).yelEntire = vertcat(condStruct.imageLocal.yelEntire);
	resultsStructArray(i).yelMembrane = vertcat(condStruct.imageLocal.yelMembrane);
	resultsStructArray(i).redEntire = vertcat(condStruct.imageLocal.redEntire);
	
	fullCellN = vertcat(condStruct.imageLocal.cellN);
	resultsStructArray(i).localCellN = sum(fullCellN(:,end));
	
end
	
end