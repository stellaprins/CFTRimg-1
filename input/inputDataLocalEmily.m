%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 1;
exp = createExperimentStruct(experimentN);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%     exp(1).expStr       = 'Emily rare muts 11-8-17_Plate_15546';
%     exp(1).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\Emily\170811 rare muts 10 uM VX770';
%     exp(1).local_quench = 'local';
%     exp(1).filePrefix   = 'Emily rare muts 11-8-17_';
%     
% 	exp(1).conditionStr = {'WT','F508del','V520F','G551D'}
%     
%     exp(1).condWells(1,:) = {'F10'};
% 	exp(1).condWells(2,:) = {'C01'};
%     exp(1).condWells(3,:) = {'C02'};
% 	exp(1).condWells(4,:) = {'C05'};
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    exp(1).expStr       = 'Emily example mutations 30-8-17_Plate_15588';
    exp(1).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\Emily\170830 YFPmCh examples';
    exp(1).local_quench = 'local';
    exp(1).filePrefix   = 'Emily example mutations 30-8-17_';
    
	exp(1).conditionStr = {'WT','F508del','V520F','G551D'}
    
    exp(1).condWells(1,:) = {'B02','B03','B04','B05','B06','B07',};
	exp(1).condWells(2,:) = {'C02','C03','C04','C05','C06','C07',};
    exp(1).condWells(3,:) = {'D02','D03','D04','D05','D06','D07',};
	exp(1).condWells(4,:) = {'E02','E03','E04','E05','E06','E07',};
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
