
experimentStr = {'05-07-2017\Stella YFP mCh 60x localisation 05-07-2017_Plate_15438'};
exp = createExperimentStruct(experimentStr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%exp(1).expStr = '05-07-2017';

	exp(1).local_quench = {'60x'};
	
	exp(1).conditionStr = {'F508del/T1064W','F508del/T1064H','F508del/T1064M','F508del/L1065W','F508del/L1065F','F508del/L1065H','F508del/L1065Q','F508del/L1065M','F508del/R1066W', 'F508del/L1066F'};
	
	exp(1).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
	exp(1).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
	exp(1).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
	exp(1).condWells(4,:) = {'B05','C05','D05','E05','F05','G05'};
	exp(1).condWells(5,:) = {'B06','C06','D06','E06','F06','G06'};
	exp(1).condWells(6,:) = {'B07','C07','D07','E07','F07','G07'};
    exp(1).condWells(7,:) = {'B08','C08','D08','E08','F08','G08'};
	exp(1).condWells(8,:) = {'B09','C09','D09','E09','F09','G09'};
	exp(1).condWells(9,:) = {'B10','C10','D10','E10','F10','G10'};
    exp(1).condWells(10,:) = {'B11','C11','D11','E11','F11','G11'};

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
% exp(2).expStr = 'exp2';
% 	exp(2).local_quench = {'60x','quench'};
% 	
% 	exp(2).conditionStr = {'WT','F508del','R1070W'};
% 	
% 	exp(2).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
% 	exp(2).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
% 	exp(2).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
% exp(3).expStr = 'exp3';
% 	exp(3).local_quench = {'60x','quench'};
% 	
% 	exp(3).conditionStr = {'WT','F508del','R1070W'};
% 	
% 	exp(3).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
% 	exp(3).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
% 	exp(3).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
% exp(4).expStr = 'exp4';
% 	exp(4).local_quench = {'60x','quench'};
% 	
% 	exp(4).conditionStr = {'WT','F508del','R1070W'};
% 	
% 	exp(4).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
% 	exp(4).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
% 	exp(4).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
% 	
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
% exp(5).expStr = 'exp4';
% 	exp(5).local_quench = {'60x','quench'};
% 	
% 	exp(5).conditionStr = {'WT','R1070W','F508del'};
% 	
% 	exp(5).condWells(1,:) = {'B02','C02','D02','E02','F02','G02'};
% 	exp(5).condWells(2,:) = {'B03','C03','D03','E03','F03','G03'};
% 	exp(5).condWells(3,:) = {'B04','C04','D04','E04','F04','G04'};
% 	
