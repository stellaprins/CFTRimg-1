function  expStruct = createExpStruct( plateStruct )
%CREATE_EXP_STRUCT create empty structs for each experiment as listed in
%'plateStruct.experimentStr'

expNames = unique(horzcat(plateStruct.experimentStr));

expN = length(expNames);
expTemplate = struct(...
			'expStr',{{}}...
			,'normConditionStr',{{}}...
			,'imageLocal',{{}}...
			,'imageQuench',{{}});

for i=1:expN
	expStruct(i) = expTemplate;
	expStruct(i).expStr = expNames{i};
end


