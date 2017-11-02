%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 1 ;
exp					= createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(1).plateStr					= {'Plate 1'};
exp(1).expStr           = 'Stella YFP mCh 60x localisation 05-07-2017_Plate_15438';
exp(1).baseFolder       = 'C:\Users\StellaPrins\Documents\DATA\Stella\05-07-2017';
exp(1).local_quench     = 'local';
exp(1).filePrefix       = 'Stella YFP mCh 60x localisation 05-07-2017_';
exp(1).conditionStr			= {'WT','F508del/R1070H','F508del/R1070Q',...
	'F508del/R1070M','F508del/P1072W','F508del/P1072Y','F508del/P1072F',...
	'F508del/P1072H','F508del/P1072Q', 'F508del/P1072M'};


exp(1).condWells(1,1:5) = {'C02','D02','E02','F02','G02'};
exp(1).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(1).condWells(3,1:5) = {'B04','C04','D04','F04','G04'};
exp(1).condWells(4,1:6) = {'B05','C05','D05','E05','F05','G05'};
exp(1).condWells(5,1:6) = {'B06','C06','D06','E06','F06','G06'};
exp(1).condWells(6,1:6) = {'B07','C07','D07','E07','F07','G07'};
exp(1).condWells(7,1:6) = {'B08','C08','D08','E08','F08','G08'};
exp(1).condWells(8,1:6) = {'B09','C09','D09','E09','F09','G09'};
exp(1).condWells(9,1:5) = {'B10','C10','E10','F10','G10'};
exp(1).condWells(10,1:6)= {'B12','C12','D12','E12','F12','G12'};



