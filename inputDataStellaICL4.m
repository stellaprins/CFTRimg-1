

experimentN = 1;
exp = createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(1).expStr = 'Stella YFP mCh 60x localisation 05-07-2017_Plate_15438';

exp(1).baseFolder	= 'E:\Stella\05-07-2017';
exp(1).local_quench = 'local';
exp(1).filePrefix   = 'Stella YFP mCh 60x localisation 05-07-2017_';
	
exp(1).conditionStr = {'F508del/T1064W','F508del/T1064H','F508del/T1064M',...
    'F508del/L1065W','F508del/L1065F','F508del/L1065H','F508del/L1065Q',...
    'F508del/L1065M','F508del/R1066W', 'F508del/L1066F'};
	exp(1).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(1).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
	exp(1).condWells(4,:) = {'B05','C05','D05','E05','F05','G05'};
	exp(1).condWells(5,:) = {'B06','C06','D06','E06','F06','G06'};
	exp(1).condWells(6,:) = {'B07','C07','D07','E07','F07','G07'};
    exp(1).condWells(7,:) = {'B08','C08','D08','E08','F08','G08'};
	exp(1).condWells(8,:) = {'B09','C09','D09','E09','F09','G09'};
	exp(1).condWells(9,:) = {'B10','C10','D10','E10','F10','G10'};
    exp(1).condWells(10,:) = {'B12','C12','D12','E12','F12','G12'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 