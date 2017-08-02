
experimentStr = { 'exp2','exp3','exp4','exp5' };
exp = createExperimentStruct(experimentStr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(1).expStr = 'exp2';
	exp(1).local_quench = {'60x','quench'};
	
	exp(1).conditionStr = {'WT','F508del','R1070W'};
	
	exp(1).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(1).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
exp(2).expStr = 'exp3';
	exp(2).local_quench = {'60x','quench'};
	
	exp(2).conditionStr = {'WT','F508del','R1070W'};
	
	exp(2).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(2).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(2).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
exp(3).expStr = 'exp4';
	exp(3).local_quench = {'60x','quench'};
	
	exp(3).conditionStr = {'WT','F508del','R1070W'};
	
	exp(3).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(3).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(3).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
exp(4).expStr = 'exp5';
	exp(4).local_quench = {'60x','quench'};
	
	exp(4).conditionStr = {'WT','R1070W','F508del'};
	
	exp(4).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(4).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(4).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
	
