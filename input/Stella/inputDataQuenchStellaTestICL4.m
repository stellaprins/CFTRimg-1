%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 4;
exp = createExperimentStruct(experimentN);
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    exp(1).expStr           = 'Stella mCherry YFP 05-07-2017_Plate_15440';
	exp(1).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\05-07-2017';
	exp(1).local_quench     = 'quench';
	exp(1).filePrefix       = 'Stella mCherry YFP 05-07-2017_';
	
    exp(1).conditionStr = {'WT','F508del/R1070H','F508del/R1070Q',...
    'F508del/R1070M','F508del/P1072W','F508del/P1072Y','F508del/P1072F',...
    'F508del/P1072H','F508del/P1072Q', 'F508del/P1072M'};
    
    exp(1).condWells(1,:)   = {'B02','C02','D02'};
    exp(1).condWells(2,:)   = {'B03','C03','D03'};
    exp(1).condWells(3,1:2) = {'B04','C04',};
    exp(1).condWells(4,1:2) = {'B05','C05'};
    exp(1).condWells(5,:)   = {'B06','C06','D06'};
    exp(1).condWells(6,:)   = {'B07','C07','D07'};
    exp(1).condWells(7,1:2)   = {'B08','C08'};
    exp(1).condWells(8,:)   = {'B09','C09','D09'};
    exp(1).condWells(9,1)   = {'B10'};
    exp(1).condWells(10,:)  = {'B12','C12','D12'};
    
    exp(1).condWellsControl(1,:)   = {'E02','F02','G02'};
    exp(1).condWellsControl(2,:)   = {'E03','F03','G03'};
    exp(1).condWellsControl(3,1)   = {'G04'};
    exp(1).condWellsControl(4,1)   = {'G05'};
    exp(1).condWellsControl(5,1)   = {'G06'};
    exp(1).condWellsControl(6,:)   = {'E07','F07','G07'};
    exp(1).condWellsControl(7,1)   = {'G08'};
    exp(1).condWellsControl(8,1:2) = {'F09','G09'};
    exp(1).condWellsControl(9,1:2) = {'F10','G10'};
    exp(1).condWellsControl(10,:)  = {'E12','F12','G12'};
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    exp(2).expStr       = 'Stella mCherry YFP 07-07-2017_Plate_15446';
    exp(2).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\Stella\07-07-2017';
	exp(2).local_quench = 'quench';
	exp(2).filePrefix   = 'Stella mCherry YFP 07-07-2017_';
	
	
    exp(2).conditionStr = {'F508del/T1064W','F508del/T1064H','F508del/T1064M',...
    'F508del/L1065W','F508del/L1065F','F508del/L1065H','F508del/L1065Q',...
    'F508del/L1065M','F508del/R1066W','F508del/R1066F'};
    exp(2).condWellsControl(1,:) = {'B02','C02','D02'};
    exp(2).condWellsControl(2,:) = {'B03','C03','D03'};
    exp(2).condWellsControl(3,:) = {'B04','C04','D04'};
    exp(2).condWellsControl(4,:) = {'B05','C05','D05'};
    exp(2).condWellsControl(5,:) = {'B06','C06','D06'};
    exp(2).condWellsControl(6,:) = {'B07','C07','D07'};
    exp(2).condWellsControl(7,:) = {'B08','C08','D08'};
    exp(2).condWellsControl(8,:) = {'B09','C09','D09'};
    exp(2).condWellsControl(9,:) = {'B10','C10','D10'};
    exp(2).condWellsControl(10,:)= {'B11','C11','D11'};
    
    exp(2).condWells(1,:) = {'E02','F02','G02'};
    exp(2).condWells(2,:) = {'E03','F03','G03'};
    exp(2).condWells(3,:) = {'E04','F04','G04'};
    exp(2).condWells(4,:) = {'E05','F05','G05'};
    exp(2).condWells(5,:) = {'E06','F06','G06'};
    exp(2).condWells(6,:) = {'E07','F07','G07'};
    exp(2).condWells(7,:) = {'E08','F08','G08'};
    exp(2).condWells(8,:) = {'E09','F09','G09'};
    exp(2).condWells(9,:) = {'E10','F10','G10'};
    exp(2).condWells(10,:)= {'E11','F11','G11'};
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    exp(3).expStr           = 'Stella mCherry YFP 12-07-2017_Plate_15454';
	exp(3).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\12-07-2017';
	exp(3).local_quench     = 'quench';
	exp(3).filePrefix       = 'Stella mCherry YFP 02-03-17_';
	
     exp(3).conditionStr = {'F508del/R1066Q','F508del/A1067W','F508del/A1067Q',...
    'F508del/F1068M','F508del/Y1073F','F508del/Y1073M','F508del/F1074W',...
    'F508del/F1074Q','F508del/A1067M','F508del/Y1073Q'};

    exp(3).condWellsControl(1,:)   = {'B02','C02','D02'};
    exp(3).condWellsControl(2,1:2) = {'C03','D03'};
    exp(3).condWellsControl(3,1:2) = {'C04','D04'};
    exp(3).condWellsControl(4,1:2) = {'C06','D06'};
    exp(3).condWellsControl(5,1:2) = {'C07','D07'};
    exp(3).condWellsControl(6,1:2) = {'C09','D09'};
    exp(3).condWellsControl(7,1:2) = {'C10','D10'};
    exp(3).condWellsControl(8,1:2) = {'C11','D11'};
    exp(3).condWellsControl(9,1:2) = {'C05','D05'};
    exp(3).condWellsControl(10,1:2) = {'C08','D08'};
        
    exp(3).condWells(1,:) = {'E02','F02','G02'};
    exp(3).condWells(2,:) = {'E03','F03','G03'};
    exp(3).condWells(3,:) = {'E04','F04','G04'};
    exp(3).condWells(4,:) = {'E06','F06','G06'};
    exp(3).condWells(5,:) = {'E07','E08','F08'};
    exp(3).condWells(6,:) = {'E09','F09','G09'};
    exp(3).condWells(7,:) = {'E10','F10','G10'};
    exp(3).condWells(8,:) = {'E11','F11','G11'};
    exp(3).condWells(9,:) = {'E05','F05','G05'};
    exp(3).condWells(10,:) = {'F07','G07','G08'};
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    exp(4).expStr           = 'Stella mCherry YFP 14-07-2017_Plate_15462';
	exp(4).baseFolder		 = 'C:\Users\StellaPrins\Documents\DATA\Stella\14-07-2017';
	exp(4).local_quench     = 'quench';
	exp(4).filePrefix       = 'Stella mCherry YFP 14-07-2017_';
	
     exp(4).conditionStr = {'F508del/F1074M','F508del/R1070M','F508del/R1070Q',...
    'F508del/P1072Q','F508del/F1074Y','F508del/A1067F','F508del/F1068W',...
    'F508del/F1068H','F508del/Q1071W','F508del/Y1073W'};
    exp(4).condWellsControl(1,:)   = {'B02','C02','D02'};
    exp(4).condWellsControl(2,1:3) = {'B03','C03','D03'};
    exp(4).condWellsControl(3,1)   = {'B04'};
    exp(4).condWellsControl(4,1:2) = {'B05','C05'};
    exp(4).condWellsControl(5,1:2) = {'B06','C06'};
    exp(4).condWellsControl(6,1:2) = {'B07','C07'};
    exp(4).condWellsControl(7,1)   = {'B08'};
    exp(4).condWellsControl(8,1:2) = {'B09','C09'};
    exp(4).condWellsControl(9,:)   = {'B10','C10','D10'};
    exp(4).condWellsControl(10,:)  = {'B11','C11','D11'};
    
    exp(4).condWells(1,:)   = {'E02','F02','G02'};
    exp(4).condWells(2,1:3) = {'E03','F03','G03'};
    exp(4).condWells(3,1:2) = {'F04','G04'};
    exp(4).condWells(4,1:2) = {'F05','G05'};
    exp(4).condWells(5,1:2) = {'E06','F06'};
    exp(4).condWells(6,1:2) = {'F07','G07'};
    exp(4).condWells(7,1:2) = {'F08','G08'}
    exp(4).condWells(9,1:2) = {'G09','F09'}
    exp(4).condWells(9,1)   = {'F10'};
    exp(4).condWells(10,:)  = {'E11','F11','G11'};

    % G10 is very blurry
    % D10 is very blurry
    % F09 is a little bit blurry but good enough to analyse (?) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
