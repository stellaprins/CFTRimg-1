function  exp = createExperiments( experimentStr )
%CREATEEXPERIMENTS create empty structs for each experiment as listed in
%'experimentStr'

experimentsN = length(experimentStr);
experimentTemplate = struct(...
			'expStr',[]...
			,'conditionStr',{{}} ...
			,'local_or_quench',{{}}...
			,'cond_wells',{{}}...
		);

for i=1:experimentsN
	exp(i) = experimentTemplate;
	exp(i).expStr = experimentStr(i);
	
end

end
