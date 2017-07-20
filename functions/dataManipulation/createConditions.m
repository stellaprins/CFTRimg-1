function  conditions = createConditions( conditionsStr )
%CREATECONDITIONS create empty structs for each conditions as listed in
%'conditionsStr'

conditionsN = length(conditionsStr);
conditionTemplate = struct(...
			'mutation',[]...
			,'cellN',[]...
			,'wells',{{}} ...
			,'images',{{}});

for i=1:conditionsN
	conditions(i) = conditionTemplate;
	conditions(i).mutation = conditionsStr(i);
	
end

end

