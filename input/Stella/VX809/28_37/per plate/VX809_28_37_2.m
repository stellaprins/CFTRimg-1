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

experimentN = 2 ;
exp					= createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% LOCALISATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(1).plateStr					= {'28°C 3'};
exp(1).expStr						= 'Stella local VX809 temp correct 03-11-17_Plate_15670';
exp(1).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(1).local_quench			= 'local';
exp(1).filePrefix				= 'Stella local VX809 temp correct 03-11-17_';

exp(1).conditionStr			= {'WT 28','F508del 28', 'F508del + VX-809 28'};
exp(1).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(1).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(1).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(2).plateStr			= {'37°C 4'};
exp(2).expStr       = 'Stella local VX809 37degrees 03-11-17 normal plate_Plate_15673 and Plate_15674';
exp(2).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(2).local_quench = 'local';
exp(2).filePrefix   = 'Stella local VX809 37degrees 03-11-17 normal plate_';

exp(2).conditionStr			= {'WT 37','F508del 37', 'F508del + VX-809 37'};
exp(2).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(2).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(2).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};
