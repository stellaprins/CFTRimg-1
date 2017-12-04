%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 1 ;
exp					= createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% LOCALISATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(1).plateStr			= {'37°C 6'};
exp(1).expStr       = 'Stella local VX809 37 23-11-17_Plate_15728';
exp(1).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\23-11-17';
exp(1).local_quench = 'local';
exp(1).filePrefix   = 'Stella local VX809 37 23-11-17_';

exp(1).conditionStr			= {'WT 37','F508del 37', 'F508del + VX-809 37'};
exp(1).condWells(1,:) = {'C02','C03','C04','C05','C06','C07','C08','C09'};
exp(1).condWells(2,:) = {'D02','D03','D04','D05','D06','D07','D08','D09'};
exp(1).condWells(3,:) = {'E02','E03','E04','E05','E06','E07','E08','E09'};

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp(2).plateStr			= {'28°C 5'};
% exp(2).expStr       = 'Stella local VX809 28 23-11-17_Plate_15730';
% exp(2).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\23-11-17';
% exp(2).local_quench = 'local';
% exp(2).filePrefix   = 'Stella local VX809 28 23-11-17_';
% 
% exp(2).conditionStr			= {'WT 28','F508del 28', 'F508del + VX-809 28'};
% exp(2).condWells(1,1:8) = {'C02','C03','C04','C05','C06','C07','C08','C09'};
% exp(2).condWells(2,1:8) = {'D02','D03','D04','D05','D06','D07','D08','D09'};
% exp(2).condWells(3,1:8) = {'E02','E03','E04','E05','E06','E07','E08','E09'};
