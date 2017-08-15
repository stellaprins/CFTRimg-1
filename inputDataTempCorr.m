
experimentN = 3;
exp = createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(1).expStr = 'Emily temp corr 10-8-17_Plate_15537';

	exp(1).baseFolder		= '~/Desktop/data';
	exp(1).local_quench = 'local';
	exp(1).filePrefix = 'Emily temp corr 10-8-17_';
	
	exp(1).conditionStr = {'WT','F508del'};
		exp(1).condWells(1,:) = {'C02','C03','C04','C05','C06','C07'};
		exp(1).condWells(2,:) = {'D02','D03','D04','D05','D06','D07'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(2).expStr = 'Emily temp corr 10-8-17_Plate_15541';

	exp(2).baseFolder		= '~/Desktop/data';
	exp(2).local_quench = 'local';
	exp(2).filePrefix = 'Emily temp corr 10-8-17_';
	
	exp(2).conditionStr = {'F508del/R1070W'};
		exp(2).condWells(1,:) = {'E02','E03','E04','E05'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(3).expStr = 'Emily temp corr 20X 10-8-17_Plate_15542';

	exp(3).baseFolder		= '~/Desktop/data';
	exp(3).local_quench = 'quench';
	exp(3).filePrefix = 'Emily temp corr 20X 10-8-17_';
	
	exp(3).conditionStr = {'WT','F508del','F508del/R1070W'};
		exp(3).condWells(1,:) = {'C05','C06','C07'};
		exp(3).condWells(2,:) = {'D05','D06','D07'};
		exp(3).condWells(3,:) = {'E05','E06','E07'};
		
		exp(3).condWellsControl(1,:) = {'C02','C03','C04'};
		exp(3).condWellsControl(2,:) = {'D02','D03','D04'};
		exp(3).condWellsControl(3,:) = {'E02','E03','E04'};

