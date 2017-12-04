% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%                WT  F508del  F508del+VX-809			  						 %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%																																 %%%	
% %%   to check whether the mCh.YFP assay can measure rescue of     %%%
% %%   F508del mislocalisation by temp correction and/or VX-809     %%%
% %%																																 %%%	
% %%								      28�C	   10uM VX-809		  								 %%%	
% %%																																 %%%	
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 4 ;
exp					= createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% LOCALISATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(1).plateStr					= {'28�C 1'};
exp(1).expStr						= 'Stella localisation 60x temp corrected VX809 expensive plate_Plate_15659';
exp(1).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(1).local_quench			= 'local';
exp(1).filePrefix				= 'Stella localisation 60x temp corrected VX809 expensive plate_';

exp(1).conditionStr			= {'WT 28','F508del 28', 'F508del + VX-809 28'};
exp(1).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(1).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(1).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(2).plateStr			= {'28�C 2'};
exp(2).expStr       = 'Stella localisation Vx809 temp corrected_Plate_15657';
exp(2).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(2).local_quench = 'local';
exp(2).filePrefix   = 'Stella localisation Vx809 temp corrected_';

exp(2).conditionStr			= {'WT 28','F508del 28', 'F508del + VX-809 28'};
exp(2).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(2).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(2).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

exp(3).plateStr					= {'37�C 1'};
exp(3).expStr						= 'Stella local VX809 37degrees expensive plate 02-11-17_Plate_15663';
exp(3).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(3).local_quench			= 'local';
exp(3).filePrefix				= 'Stella local VX809 37degrees expensive plate 02-11-17_';

exp(3).conditionStr			= {'WT 37','F508del 37', 'F508del + VX-809 37'};
exp(3).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(3).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(3).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(4).plateStr			= {'37�C 2'};
exp(4).expStr       = 'Stella local VX809  02-11-17  37degrees normal plate_Plate_15660';
exp(4).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(4).local_quench = 'local';
exp(4).filePrefix   = 'Stella local VX809  02-11-17  37degrees normal plate_';

exp(4).conditionStr			= {'WT 37','F508del 37', 'F508del + VX-809 37'};
exp(4).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(4).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(4).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};