
experimentStr = { 'exp1','exp2','exp3','exp4','exp5' };
exp = createExperiments(experimentStr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(1).expStr = 'exp1';
	exp(1).local_or_quench = {'60x'};
	
	exp(1).conditionsStr = {'WT','F508del','R1070W'};
	
	exp(1).cond_wells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(1).cond_wells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(1).cond_wells(3,:) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
exp(2).expStr = 'exp2';
	exp(2).local_or_quench = {'60x','quench'};
	
	exp(2).conditionsStr = {'WT','F508del','R1070W'};
	
	exp(2).cond_wells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(2).cond_wells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(2).cond_wells(3,:) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
exp(3).expStr = 'exp3';
	exp(3).local_or_quench = {'60x','quench'};
	
	exp(3).conditionsStr = {'WT','F508del','R1070W'};
	
	exp(3).cond_wells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(3).cond_wells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(3).cond_wells(3,:) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
exp(4).expStr = 'exp4';
	exp(4).local_or_quench = {'60x','quench'};
	
	exp(4).conditionsStr = {'WT','F508del','R1070W'};
	
	exp(4).cond_wells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(4).cond_wells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(4).cond_wells(3,:) = {'B04','C04','D04','E04','F04','G04'};
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
exp(5).expStr = 'exp4';
	exp(5).local_or_quench = {'60x','quench'};
	
	exp(5).conditionsStr = {'WT','R1070W','F508del'};
	
	exp(5).cond_wells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(5).cond_wells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(5).cond_wells(3,:) = {'B04','C04','D04','E04','F04','G04'};
	
