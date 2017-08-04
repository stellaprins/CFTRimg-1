function  exp = createExperimentStruct( experimentStr )
%CREATEEXPERIMENTS create empty structs for each experiment as listed in
%'experimentStr'

experimentN = length(experimentStr);
experimentTemplate = struct(...
			'expStr',[]...
			,'conditionStr',{{}} ...
			,'local_quench',{{}}...
			,'condWells',{{}}...
		);

for i=1:experimentN
	exp(i) = experimentTemplate;
	exp(i).expStr = experimentStr{i};
	
end

end
