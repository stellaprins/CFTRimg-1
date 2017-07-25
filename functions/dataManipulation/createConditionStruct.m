function  conditionStruct = createConditionStruct( experimentStruct )
%CREATECONDITIONS create empty structs for each condition as listed in
%'experimentStruct.conditionsStr'

conditionsStr = unique(horzcat(experimentStruct.conditionStr));

conditionsN = length(conditionsStr);
conditionTemplate = struct(...
			'mutation',[]...
			,'cellN',[]...
			,'hits',[]...
			,'images',{{}});

for i=1:conditionsN
	conditionStruct(i) = conditionTemplate;
	conditionStruct(i).mutation = conditionsStr(i);
end


