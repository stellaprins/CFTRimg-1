
experimentN = 2;
exp = createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(1).expStr = 'Stella YFP mCh 2017-07-05 Plate_15433 localisation';

	exp(1).baseFolder		= '~/Desktop/data/exp2';
	exp(1).local_quench = 'local';
	exp(1).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp(1).conditionStr = {'WT','F508del','R1070W'};
		exp(1).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		exp(1).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
exp(2).expStr = 'Stella YFP mCh 2017-07-05 Plate_15435';

	exp(2).baseFolder		= '~/Desktop/data/exp2';
	exp(2).local_quench = 'quench';
	exp(2).filePrefix = 'Stella mCherry YFP 05-07-2017 Katie_';
	
	exp(2).conditionStr = {'WT','F508del','R1070W'};
		exp(2).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp(2).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		exp(2).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};