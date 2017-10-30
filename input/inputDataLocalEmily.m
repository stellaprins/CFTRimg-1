%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 1;
exp = createExperimentStruct(experimentN);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    exp(1).expStr       = 'Emily rare muts 11-8-17_Plate_15546';
    exp(1).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\Emily\170811 rare muts 10 uM VX770';
    exp(1).local_quench = 'local';
    exp(1).filePrefix   = 'Emily rare muts 11-8-17_';
    
	exp(1).conditionStr = {'WT','F508del','V520F','G551D'}
    
    exp(1).condWells(1,:) = {'F10'};
	exp(1).condWells(2,:) = {'C01'};
    exp(1).condWells(3,:) = {'C02'};
	exp(1).condWells(4,:) = {'C05'};
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% C:\Users\StellaPrins\Documents\DATA\Emily\170811 rare muts 10 uM VX770\Emily rare muts 11-8-17_Plate_15546\TimePoint_1
%     exp(1).expStr       = 'Emily rare muts 11-8-17_Plate_15546';
%     exp(1).baseFolder	= 'C:\Users\StellaPrins\Documents\DATA\Emily\170811 rare muts 10 uM VX770';
%     exp(1).local_quench = 'local';
%     exp(1).filePrefix   = 'Emily rare muts 11-8-17_';
%     
% 	exp(1).conditionStr = {'WT','F508del','V520F','G551D')
%     
%     exp(1).condWells(1,:) = {'F10'};
% 	exp(1).condWells(2,:) = {'C1'};
%     exp(1).condWells(3,:) = {'C2'};
% 	exp(1).condWells(4,:) = {'C5'};
    
