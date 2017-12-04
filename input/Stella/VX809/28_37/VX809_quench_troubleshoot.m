%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                WT  F508del  F508del+VX-809			  						 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																																 %%%	
%%%   to check whether the mCh.YFP assay can measure rescue of     %%%
%%%   F508del mislocalisation by temp correction and/or VX-809     %%%
%%%																																 %%%	
%%%								      28°C	   10uM VX-809		  								 %%%	
%%%																																 %%%	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 1 ;
exp					= createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% QUENCHING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(1).plateStr			= {'28°C 3'};
exp(1).expStr       = 'Stella quench VX809 28 23-11-17_Plate_15731';
exp(1).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\23-11-17';
exp(1).local_quench = 'quench';
exp(1).filePrefix		= 'Stella quench VX809 28 23-11-17_';
exp(1).conditionStr	= {'WT + VX-770 28°C','F508del + VX-770 28°C', 'F508del + VX-809 + VX-770 28°C'};

exp(1).condWells(1,1:4) = {'C02','C04','D06','C08'};
exp(1).condWells(2,1:4) = {'D02','D04','D06','D08'};
exp(1).condWells(3,1:4) = {'E02','E04','D06','E08'};


exp(1).condWellsControl(1,1:4) =  {'C03','C05','C07','C09'};
exp(1).condWellsControl(2,1:4) =  {'D03','D05','D07','D09'};
exp(1).condWellsControl(3,1:4) =  {'E03','E05','E07','E09'};

% exp(1).plateStr			= {'28°C 1'};
% exp(1).expStr       = 'Stella quenching 02-11-2017 TEMP CORRECT normal plate_Plate_15658';
% exp(1).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
% exp(1).local_quench = 'quench';
% exp(1).filePrefix		= 'Stella quenching 02-11-2017 TEMP CORRECT normal plate_';
% exp(1).conditionStr	= {'F508del 28°C', 'F508del + VX-809 + VX-770 28°C'};
% 
% exp(1).condWells(1,1:3) = {'B03','C03','D03'};
% exp(1).condWells(1,1:3) = {'B04','C04','D04'};
% 
% exp(1).condWellsControl(1,1:3) = {'E03','F03','G03'};
% exp(1).condWellsControl(2,1:3) = {'E04','F04','G04'};

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp(1).plateStr			= {'28°C 2'};
% exp(1).expStr       = 'Stella quench VX809 temp correct 13-10-2017_Plate_15671';
% exp(1).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
% exp(1).local_quench = 'quench';
% exp(1).filePrefix		= 'Stella quench VX809 temp correct 13-10-2017_';
% exp(1).conditionStr	= {'F508del 28°C', 'F508del + VX-809 + VX-770 28°C'};
% 
% exp(1).condWells(1,1:3) = {'B03','C03','D03'};
% exp(1).condWells(1,1:3) = {'B04','C04','D04'};
% 
% exp(1).condWellsControl(1,1:3) = {'E03','F03','G03'};
% exp(1).condWellsControl(2,1:3) = {'E04','F04','G04'};

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% exp(1).plateStr			= {'28°C 3'};
% exp(1).expStr       = 'Stella quench VX809 28 23-11-17_Plate_15731';
% exp(1).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\23-11-17';
% exp(1).local_quench = 'quench';
% exp(1).filePrefix		= 'Stella quench VX809 28 23-11-17_';
% exp(1).conditionStr	= {'F508del + VX-809 + VX-770 28°C'};
% 
% % exp(1).condWells(1,1:4) = {'D02','D04','D06','D08'}; %must have added forskolin
% exp(1).condWells(2,1:4) = {'E02','E04','D06','E08'};
% 
% % exp(1).condWellsControl(1,1:4) =  {'D03','D05','D07','D09'};
% exp(1).condWellsControl(2,1:4) =  {'E03','E05','E07','E09'};
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% exp(1).plateStr			= {'28°C 4'};
% exp(1).expStr       = 'Stella quench VX809 28 24-11-2017_Plate_15734';
% exp(1).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\24-11-17';
% exp(1).local_quench = 'quench';
% exp(1).filePrefix		= 'Stella quench VX809 28 24-11-2017_';
% exp(1).conditionStr	= {'F508del + VX-770 28°C', 'F508del + VX-809 + VX-770 28°C'};
% 
% exp(1).condWells(1,1) = {'D08'};
% exp(1).condWells(2,1:3) = {'E02','E04','E08'};
% 
% exp(1).condWellsControl(1,1:4) =  {'D03','D05','D07','D09'};
% exp(1).condWellsControl(2,1:4) =  {'E03','E05','E07','E09'};
% 


% 
