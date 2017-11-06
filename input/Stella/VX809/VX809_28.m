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

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%% LOCALISATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp(1).plateStr					= {'28°C 1'};
% exp(1).expStr						= 'Stella localisation 60x temp corrected VX809 expensive plate_Plate_15659';
% exp(1).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
% exp(1).local_quench			= 'local';
% exp(1).filePrefix				= 'Stella localisation 60x temp corrected VX809 expensive plate_';
% 
% exp(1).conditionStr			= {'WT','F508del', 'F508del + VX-809'};
% exp(1).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
% exp(1).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
% exp(1).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp(2).plateStr			= {'28°C 2'};
% exp(2).expStr       = 'Stella localisation Vx809 temp corrected_Plate_15657';
% exp(2).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
% exp(2).local_quench = 'local';
% exp(2).filePrefix   = 'Stella localisation Vx809 temp corrected_';
% 
% exp(2).conditionStr			= {'WT','F508del', 'F508del + VX-809'};
% exp(2).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
% exp(2).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
% exp(2).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp(3).plateStr					= {'28°C 3'};
% exp(3).expStr						= 'Stella local VX809 temp correct 03-11-17_Plate_15670';
% exp(3).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
% exp(3).local_quench			= 'local';
% exp(3).filePrefix				= 'Stella local VX809 temp correct 03-11-17_';
% 
% exp(3).conditionStr			= {'WT','F508del', 'F508del + VX-809'};
% exp(3).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
% exp(3).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
% exp(3).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% exp(4).plateStr			= {'28°C 4'};
% exp(4).expStr       = 'Stella local VX809 temp correct 03-11-17 expensive plate_Plate_15672';
% exp(4).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
% exp(4).local_quench = 'local';
% exp(4).filePrefix   = 'Stella local VX809 temp correct 03-11-17 expensive plate_';
% 
% exp(4).conditionStr			= {'WT','F508del', 'F508del + VX-809'};
% exp(4).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
% exp(4).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
% exp(4).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% QUENCHING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(1).plateStr			= {'28°C 3'};
exp(1).expStr       = 'Stella quenching 02-11-2017 TEMP CORRECT normal plate_Plate_15658';
exp(1).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(1).local_quench = 'quench';
exp(1).filePrefix		= 'Stella quenching 02-11-2017 TEMP CORRECT normal plate_';
exp(1).conditionStr	= {'WT','F508del', 'F508del + VX-809'};

exp(1).condWells(1,1:3) = {'B02','C02','D02'};
exp(1).condWells(2,1:3) = {'B03','C03','D03'};
exp(1).condWells(3,1:3) = {'B04','C04','D04'};

exp(1).condWellsControl(1,1:3) =  {'E02','F02','G02'};
exp(1).condWellsControl(2,1:3) = {'E03','F03','G03'};
exp(1).condWellsControl(3,1:3) = {'E04','F04','G04'};

