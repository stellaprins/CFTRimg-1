

experimentN = 2;
exp = createExperimentStruct(experimentN);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(1).expStr = 'Stella YFP mCh 60x localisation 05-07-2017_Plate_15438';

exp(1).baseFolder	= 'E:\Stella\05-07-2017';
exp(1).local_quench = 'local';
exp(1).filePrefix   = 'Stella YFP mCh 60x localisation 05-07-2017_';
	
exp(1).conditionStr = {'F508del/T1064W','F508del/T1064H','F508del/T1064M',...
    'F508del/L1065W','F508del/L1065F','F508del/L1065H','F508del/L1065Q',...
    'F508del/L1065M','F508del/R1066W', 'F508del/L1066F'};
    exp(1).condWells(1,:) = {'B02'};
	exp(1).condWells(2,:) = {'B03'};
    exp(1).condWells(3,:) = {'B04'};
	exp(1).condWells(4,:) = {'B05'};
	exp(1).condWells(5,:) = {'B06'};
	exp(1).condWells(6,:) = {'B07'};
    exp(1).condWells(7,:) = {'B08'};
	exp(1).condWells(8,:) = {'B09'};
    exp(1).condWells(9,:) = {'B10'};
    exp(1).condWells(10,:) = {'B12'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 exp(2).expStr = 'Stella mCherry YFP 05-07-2017_Plate_15440';

	exp(2).baseFolder		= 'E:\Stella\05-07-2017';
	exp(2).local_quench = 'quench';
	exp(2).filePrefix = 'Stella mCherry YFP 05-07-2017_';
	
exp(2).conditionStr = {'F508del/T1064W','F508del/T1064H','F508del/T1064M',...
    'F508del/L1065W','F508del/L1065F','F508del/L1065H','F508del/L1065Q',...
    'F508del/L1065M','F508del/R1066W', 'F508del/L1066F'};
    exp(2).condWells(1,:) = {'B02','C02'};
	exp(2).condWells(2,1) = {'B03'};
    exp(2).condWells(3,1) = {'B04'};
	exp(2).condWells(4,1) = {'B05'};
	exp(2).condWells(5,1) = {'B06'};
	exp(2).condWells(6,1) = {'B07'};
    exp(2).condWells(7,1) = {'B08'};
	exp(2).condWells(8,1) = {'B09'};
    exp(2).condWells(9,1) = {'B10'};
    exp(2).condWells(10,1) = {'B12'};
    
    exp(2).condWellsControl(1,1) = {'E02'};
	exp(2).condWellsControl(2,1) = {'E03'};
    exp(2).condWellsControl(3,1) = {'G04'};
	exp(2).condWellsControl(4,1) = {'G05'};
	exp(2).condWellsControl(5,1) = {'G06'};
	exp(2).condWellsControl(6,1) = {'E07'};
    exp(2).condWellsControl(7,1) = {'G08'};
	exp(2).condWellsControl(8,1) = {'G09'};
    exp(2).condWellsControl(10,1) = {'E12'};
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%