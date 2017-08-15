
experimentN = 10;
exp = createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(1).expStr = 'Stella YFP mCh 2017-06-29 Plate_15419 localisation';

	exp(1).baseFolder		= '~/Desktop/data';
	exp(1).local_quench = 'local';
	exp(1).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp(1).conditionStr = {'WT','F508del','F508del/R1070W'};
		exp(1).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		exp(1).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(2).expStr = 'Stella YFP mCh 2017-07-05 Plate_15433 localisation';

	exp(2).baseFolder		= '~/Desktop/data';
	exp(2).local_quench = 'local';
	exp(2).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp(2).conditionStr = {'WT','F508del','F508del/R1070W'};
		exp(2).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp(2).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		exp(2).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(3).expStr = 'Stella YFP mCh 2017-07-05 Plate_15435';

	exp(3).baseFolder		= '~/Desktop/data';
	exp(3).local_quench = 'quench';
	exp(3).filePrefix = 'Stella mCherry YFP 05-07-2017 Katie_';
	
	exp(3).conditionStr = {'WT','F508del','F508del/R1070W'};
		exp(3).condWells(1,:) = {'B02','C02','D02'};
		exp(3).condWells(2,:) = {'B03','C03','D03'};
		exp(3).condWells(3,:) = {'B04','C04','D04'};
		
		exp(3).condWellsControl(1,:) = {'E02','F02','G02'};
		exp(3).condWellsControl(2,:) = {'E03','F03','G03'};
		exp(3).condWellsControl(3,:) = {'E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(4).expStr = 'Stella YFP mCh 2017-07-12 Plate_15451 localisation';

	exp(4).baseFolder		= '~/Desktop/data';
	exp(4).local_quench = 'local';
	exp(4).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp(4).conditionStr = {'WT','F508del','F508del/R1070W'};
		exp(4).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp(4).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		exp(4).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(5).expStr = 'Stella YFP mCh 2017-07-12 Plate_15452';

	exp(5).baseFolder		= '~/Desktop/data';
	exp(5).local_quench = 'quench';
	exp(5).filePrefix = 'Stella mCherry YFP 2017-07-12_';
	
	exp(5).conditionStr = {'WT','F508del','F508del/R1070W'};
		exp(5).condWells(1,:) = {'B02','C02','D02'};
		exp(5).condWells(2,:) = {'B03','C03','D03'};
		exp(5).condWells(3,:) = {'B04','C04','D04'};
		
		exp(5).condWellsControl(1,:) = {'E02','F02','G02'};
		exp(5).condWellsControl(2,:) = {'E03','F03','G03'};
		exp(5).condWellsControl(3,:) = {'E04','F04','G04'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(6).expStr = 'Stella YFP mCh 2017-07-14 Plate_15463 localisation';

	exp(6).baseFolder		= '~/Desktop/data';
	exp(6).local_quench = 'local';
	exp(6).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp(6).conditionStr = {'WT','F508del'};
		exp(6).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp(6).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(7).expStr = 'Stella YFP mCh 2017-07-14 Plate_15464 localisation';

	exp(7).baseFolder		= '~/Desktop/data';
	exp(7).local_quench = 'local';
	exp(7).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp(7).conditionStr = {'F508del/R1070W'};
		exp(7).condWells(1,:) = {'B04','C04','D04','E04','F04','G04'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(8).expStr = 'Stella YFP mCh 2017-07-14 Plate_15465';

	exp(8).baseFolder		= '~/Desktop/data';
	exp(8).local_quench = 'quench';
	exp(8).filePrefix = 'Stella mCherry YFP 14-07-2017_';
	
	exp(8).conditionStr = {'WT','F508del','F508del/R1070W'};
		exp(8).condWells(1,:) = {'B02','C02','D02'};
		exp(8).condWells(2,:) = {'B03','C03','D03'};
		exp(8).condWells(3,:) = {'B04','C04','D04'};
		
		exp(8).condWellsControl(1,:) = {'E02','F02','G02'};
		exp(8).condWellsControl(2,:) = {'E03','F03','G03'};
		exp(8).condWellsControl(3,:) = {'E04','F04','G04'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(9).expStr = 'Stella YFP mCh 2017-07-21 Plate_15485 localisation';

	exp(9).baseFolder		= '~/Desktop/data';
	exp(9).local_quench = 'local';
	exp(9).filePrefix = 'Stella YFP mCh 60x localisation_';
	
	exp(9).conditionStr = {'WT','F508del/R1070W','F508del'};
		exp(9).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
		exp(9).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
		exp(9).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(10).expStr = 'Stella YFP mCh 2017-07-21 Plate_15486';

	exp(10).baseFolder		= '~/Desktop/data';
	exp(10).local_quench = 'quench';
	exp(10).filePrefix = 'Stella mCherry YFP 2017-07-21_';
	
	exp(10).conditionStr = {'WT','F508del/R1070W','F508del'};
		exp(10).condWells(1,:) = {'E02','F02','G02'};
		exp(10).condWells(2,:) = {'E03','F03','G03'};
		exp(10).condWells(3,:) = {'E04','F04','G04'};
		
		exp(10).condWellsControl(1,:) = {'B02','C02','D02'};
		exp(10).condWellsControl(2,:) = {'B03','C03','D03'};
		exp(10).condWellsControl(3,:) = {'B04','C04','D04'};
