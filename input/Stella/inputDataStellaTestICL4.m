%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 9;
exp = createExperimentStruct(experimentN);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    exp(1).expStr       = 'Stella YFP mCh 60x localisation 30-06-2017_Plate_15425';
    exp(1).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\30-06-2017';
    exp(1).local_quench = 'local';
    exp(1).filePrefix   = 'Stella YFP mCh 60x localisation 30-06-2017_';
	
    exp(1).conditionStr = {'F508del/G1069W','F508del/G1069Y',...
    'F508del/G1069F','F508del/G1069H','F508del/G1069Q','F508del/G1069M',...
    'F508del/R1070Y','F508del/R1070F','F508del/R1070H'};
	exp(1).condWells(2,:) = {'B03'};
    exp(1).condWells(3,:) = {'B04'};
	exp(1).condWells(4,:) = {'B05'};
	exp(1).condWells(5,:) = {'B06'};
	exp(1).condWells(6,:) = {'B07'};
    exp(1).condWells(7,:) = {'B08'};
	exp(1).condWells(8,:) = {'B09'};
    exp(1).condWells(9,:) = {'B10'};
    exp(1).condWells(10,:) = {'B11'};
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    exp(2).expStr           = 'Stella YFP mCh 60x localisation 05-07-2017_Plate_15438';
    exp(2).baseFolder       = 'C:\Users\StellaPrins\Documents\DATA\05-07-2017';
    exp(2).local_quench     = 'local';
    exp(2).filePrefix       = 'Stella YFP mCh 60x localisation 05-07-2017_';
	
    exp(2).conditionStr = {'WT','F508del/R1070H','F508del/R1070Q',...
    'F508del/R1070M','F508del/P1072W','F508del/P1072Y','F508del/P1072F',...
    'F508del/P1072H','F508del/P1072Q', 'F508del/P1072M'};
    exp(2).condWells(1,1) = {'C02'};
	exp(2).condWells(2,1) = {'B03'};
    exp(2).condWells(3,1) = {'B04'};
	exp(2).condWells(4,:)   = {'B05'};
	exp(2).condWells(5,:)   = {'B06'};
	exp(2).condWells(6,:)   = {'B07'};
    exp(2).condWells(7,:)   = {'B08'};
	exp(2).condWells(8,:)   = {'B09'};
    exp(2).condWells(9,1) = {'B10'};
    exp(2).condWells(10,:)  = {'B12'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
exp(3).expStr       = 'Stella YFP mCh 60x localisation 07-07-2017_Plate_15445';
exp(3).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\07-07-2017';
exp(3).local_quench = 'local';
exp(3).filePrefix   = 'Stella YFP mCh 60x localisation 07-07-2017_';
	
    exp(3).conditionStr = {'F508del/T1064W','F508del/T1064H','F508del/T1064M',...
    'F508del/L1065W','F508del/L1065F','F508del/L1065H','F508del/L1065Q',...
    'F508del/L1065M','F508del/R1066W','F508del/R1066F'};
    exp(3).condWells(1,:) = {'B02'};
    exp(3).condWells(2,:) = {'B03'};
    exp(3).condWells(3,:) = {'B04'};
    exp(3).condWells(4,:) = {'B05'};
    exp(3).condWells(5,:) = {'B06'};
    exp(3).condWells(6,:) = {'B07'};
    exp(3).condWells(7,:) = {'B08'};
    exp(3).condWells(8,:) = {'B09'};
    exp(3).condWells(9,:) = {'B10'};
    exp(3).condWells(10,:) = {'B11'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(7).expStr       = 'Stella YFP mCh 60x localisation 12-07-2017_Plate_15453';
exp(7).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\12-07-2017';
exp(7).local_quench = 'local';
exp(7).filePrefix   = 'Stella YFP mCh 60x localisation 12-07-2017_';
	
    exp(7).conditionStr = {'F508del/R1066Q','F508del/A1067W','F508del/A1067Q',...
    'F508del/F1068M','F508del/Y1073F','F508del/Y1073M','F508del/F1074W',...
    'F508del/F1074Q'};
    exp(7).condWells(1,:)   = {'B02',};
    exp(7).condWells(2,1) = {'C03'};
    exp(7).condWells(3,1) = {'C04'};
    exp(7).condWells(4,1) = {'C06'};
    exp(7).condWells(5,1) = {'C07'};
    exp(7).condWells(6,1) = {'C09'};
    exp(7).condWells(7,1) = {'C10'};
    exp(7).condWells(8,1) = {'C11'};
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    exp(9).expStr         = 'Stella YFP mCh 60x localisation 14-07-2017_Plate_15461';
    exp(9).baseFolder     = 'C:\Users\StellaPrins\Documents\DATA\14-07-2017';
    exp(9).local_quench   = 'local';
    exp(9).filePrefix     = 'Stella YFP mCh 60x localisation 14-07-2017_';
	
    exp(9).conditionStr = {'F508del/F1074M','F508del/R1070M','F508del/R1070Q',...
    'F508del/P1072Q','F508del/F1074Y','F508del/A1067F','F508del/F1068W',...
    'F508del/F1068H','F508del/Q1071W','F508delY1073W'};
    exp(9).condWells(1,:)   = {'B02'};
    exp(9).condWells(2,1) = {'B03'};
    exp(9).condWells(3,1) = {'B04'};
    exp(9).condWells(4,1) = {'B05'};
    exp(9).condWells(5,1) = {'B06'};
    exp(9).condWells(6,:)   = {'B07'};
    exp(9).condWells(7,1) = {'B08'};
    exp(9).condWells(8,1) = {'B09'};
    exp(9).condWells(9,1) = {'B10'};
    exp(9).condWells(10,:)  = {'B11'};


 


%     exp(1).expStr       = 'Stella YFP mCh 60x localisation 30-06-2017_Plate_15425';
%     exp(1).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\30-06-2017';
%     exp(1).local_quench = 'local';
%     exp(1).filePrefix   = 'Stella YFP mCh 60x localisation 30-06-2017_';
% 	
%     exp(1).conditionStr = {'F508del','F508del/G1069W','F508del/G1069Y',...
%     'F508del/G1069F','F508del/G1069H','F508del/G1069Q','F508del/G1069M',...
%     'F508del/R1070Y','F508del/R1070F','F508del/R1070H'};
%     exp(1).condWells(1,:) = {'B02', 'C02','D02','E02','F02','G02'};
% 	exp(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
%     exp(1).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
% 	exp(1).condWells(4,:) = {'B05','C05','D05','E05','F05','G05'};
% 	exp(1).condWells(5,:) = {'B06','C06','D06','E06','F06','G06'};
% 	exp(1).condWells(6,:) = {'B07','C07','D07','E07','F07','G07'};
%     exp(1).condWells(7,:) = {'B08','C08','D08','E08','F08','G08'};
% 	exp(1).condWells(8,:) = {'B09','C09','D09','E09','F09','G09'};
%     exp(1).condWells(9,:) = {'B10','C10','D10','E10','F10','G10'};
%     exp(1).condWells(10,:) = {'B11','C11','D11','E11','F11','G11'};
%     
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%     exp(2).expStr           = 'Stella YFP mCh 60x localisation 05-07-2017_Plate_15438';
%     exp(2).baseFolder       = 'C:\Users\StellaPrins\Documents\DATA\05-07-2017';
%     exp(2).local_quench     = 'local';
%     exp(2).filePrefix       = 'Stella YFP mCh 60x localisation 05-07-2017_';
% 	
%     exp(2).conditionStr = {'WT','F508del/R1070H','F508del/R1070Q',...
%     'F508del/R1070M','F508del/P1072W','F508del/P1072Y','F508del/P1072F',...
%     'F508del/P1072H','F508del/P1072Q', 'F508del/P1072M'};
%     exp(2).condWells(1,1:5) = {'C02','D02','E02','F02','G02'};
% 	exp(2).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
%     exp(2).condWells(3,1:5) = {'B04','C04','D04','F04','G04'};
% 	exp(2).condWells(4,:)   = {'B05','C05','D05','E05','F05','G05'};
% 	exp(2).condWells(5,:)   = {'B06','C06','D06','E06','F06','G06'};
% 	exp(2).condWells(6,:)   = {'B07','C07','D07','E07','F07','G07'};
%     exp(2).condWells(7,:)   = {'B08','C08','D08','E08','F08','G08'};
% 	exp(2).condWells(8,:)   = {'B09','C09','D09','E09','F09','G09'};
%     exp(2).condWells(9,1:5) = {'B10','C10','E10','F10','G10'};
%     exp(2).condWells(10,:)  = {'B12','C12','D12','E12','F12','G12'};
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
% exp(3).expStr       = 'Stella YFP mCh 60x localisation 07-07-2017_Plate_15445';
% exp(3).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\07-07-2017';
% exp(3).local_quench = 'local';
% exp(3).filePrefix   = 'Stella YFP mCh 60x localisation 07-07-2017_';
% 	
%     exp(3).conditionStr = {'F508del/T1064W','F508del/T1064H','F508del/T1064M',...
%     'F508del/L1065W','F508del/L1065F','F508del/L1065H','F508del/L1065Q',...
%     'F508del/L1065M','F508del/R1066W','F508del/R1066F'};
%     exp(3).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
%     exp(3).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
%     exp(3).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
%     exp(3).condWells(4,:) = {'B05','C05','D05','E05','F05','G05'};
%     exp(3).condWells(5,:) = {'B06','C06','D06','E06','F06','G06'};
%     exp(3).condWells(6,:) = {'B07','C07','D07','E07','F07','G07'};
%     exp(3).condWells(7,:) = {'B08','C08','D08','E08','F08','G08'};
%     exp(3).condWells(8,:) = {'B09','C09','D09','E09','F09','G09'};
%     exp(3).condWells(9,:) = {'B10','C10','D10','E10','F10','G10'};
%     exp(3).condWells(10,:) = {'B11','C11','D11','E11','F11','G11'};
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% exp(7).expStr       = 'Stella YFP mCh 60x localisation 12-07-2017_Plate_15453';
% exp(7).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\12-07-2017';
% exp(7).local_quench = 'local';
% exp(7).filePrefix   = 'Stella YFP mCh 60x localisation 12-07-2017_';
% 	
%     exp(7).conditionStr = {'F508del/R1066Q','F508del/A1067W','F508del/A1067Q',...
%     'F508del/F1068M','F508del/Y1073F','F508del/Y1073M','F508del/F1074W',...
%     'F508del/F1074Q'};
%     exp(7).condWells(1,:)   = {'B02','C02','D02','E02','F02','G02'};
%     exp(7).condWells(2,1:5) = {'C03','D03','E03','F03','G03'};
%     exp(7).condWells(3,1:5) = {'C04','D04','E04','F04','G04'};
%     exp(7).condWells(4,1:5) = {'C06','D06','E06','F06','G06'};
%     exp(7).condWells(5,1:5) = {'C07','D07','E07','E08','F08'};
%     exp(7).condWells(6,1:5) = {'C09','D09','E09','F09','G09'};
%     exp(7).condWells(7,1:5) = {'C10','D10','E10','F10','G10'};
%     exp(7).condWells(8,1:5) = {'C11','D11','E11','F11','G11'};
%      
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%     exp(9).expStr         = 'Stella YFP mCh 60x localisation 14-07-2017_Plate_15461';
%     exp(9).baseFolder     = 'C:\Users\StellaPrins\Documents\DATA\14-07-2017';
%     exp(9).local_quench   = 'local';
%     exp(9).filePrefix     = 'Stella YFP mCh 60x localisation 14-07-2017_';
% 	
%     exp(9).conditionStr = {'F508del/F1074M','F508del/R1070M','F508del/R1070Q',...
%     'F508del/P1072Q','F508del/F1074Y','F508del/A1067F','F508del/F1068W',...
%     'F508del/F1068H','F508del/Q1071W','F508delY1073W'};
%     exp(9).condWells(1,:)   = {'B02','C02','D02','E02','F02','G02'};
%     exp(9).condWells(2,1:4) = {'B03','C03','F03','G03'};
%     exp(9).condWells(3,1:4) = {'B04','C04','F04','G04'};
%     exp(9).condWells(4,1:4) = {'B05','C05','F05','G05'};
%     exp(9).condWells(5,1:4) = {'B06','C06','F06','G06'};
%     exp(9).condWells(6,:)   = {'B07','C07','D07','E07','F07','G07'};
%     exp(9).condWells(7,1:3) = {'B08','C08','D08'};
%     exp(9).condWells(8,1:2) = {'B09','C09'};
%     exp(9).condWells(9,1:4) = {'B10','C10','D10','F10'};
%     exp(9).condWells(10,:)  = {'B11','C11','D11','E11','F11','G11'};
% 
% 
