%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                WT  F508del  F508del+VX-809			  						 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																																 %%%	
%%%   to check whether the mCh.YFP assay can measure rescue of     %%%
%%%   F508del mislocalisation by temp correction and/or VX-809     %%%
%%%																																 %%%	
%%%								       10uM VX-809		  			`									 %%%	
%%%																																 %%%	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 11 ;
exp					= createExperimentStruct(experimentN);

% 
% 1 28°C 02-11-17 Stella localisation 60x temp corrected VX809 expensive plate_Plate_15659
% 2 28°C 02-11-17 Stella localisation Vx809 temp corrected_Plate_15657
% 3 28°C 03-11-17 Stella local VX809 temp correct 03-11-17_Plate_15670
% 4 28°C 03-11-17 Stella local VX809 temp correct 03-11-17 expensive plate_Plate_15672
% 5 28°C 23-11-17 Stella local VX809 28 23-11-17_Plate_15730
% 6 28°C 24-11-17 Stella local VX809 28 24-11-17_Plate_15733
% 7 37°C 02-11-17 Stella local VX809  02-11-17  37degrees normal plate_Plate_15660
% 8 37°C 02-11-17 Stella local VX809  02-11-17  37degrees normal plate_Plate_15660
% 9 37°C 03-11-17 Stella local VX809 37degrees 03-11-17 expensive plate_Plate_15676
% 10 37°C 03-11-17 Stella local VX809 37degrees 03-11-17 normal plate_Plate_15673 and Plate_15674
% 11 37°C 23-11-17 Stella local VX809 37 23-11-17_Plate_15728

%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% LOCALISATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(1).plateStr					= {'28°C 1'};
exp(1).expStr						= 'Stella localisation 60x temp corrected VX809 expensive plate_Plate_15659';
exp(1).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(1).local_quench			= 'local';
exp(1).filePrefix				= 'Stella localisation 60x temp corrected VX809 expensive plate_';

exp(1).conditionStr			= {'WT 28','F508del 28', 'F508del + VX-809 28'};
exp(1).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(1).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(1).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(2).plateStr			= {'28°C 2'};
exp(2).expStr       = 'Stella localisation Vx809 temp corrected_Plate_15657';
exp(2).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(2).local_quench = 'local';
exp(2).filePrefix   = 'Stella localisation Vx809 temp corrected_';

exp(2).conditionStr			= {'WT 28','F508del 28', 'F508del + VX-809 28'};
exp(2).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(2).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(2).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(3).plateStr					= {'28°C 3'};
exp(3).expStr						= 'Stella local VX809 temp correct 03-11-17_Plate_15670';
exp(3).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(3).local_quench			= 'local';
exp(3).filePrefix				= 'Stella local VX809 temp correct 03-11-17_';

exp(3).conditionStr			= {'WT 28','F508del 28', 'F508del + VX-809 28'};
exp(3).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(3).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(3).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(4).plateStr			= {'28°C 4'};
exp(4).expStr       = 'Stella local VX809 temp correct 03-11-17 expensive plate_Plate_15672';
exp(4).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(4).local_quench = 'local';
exp(4).filePrefix   = 'Stella local VX809 temp correct 03-11-17 expensive plate_';

exp(4).conditionStr			= {'WT 28','F508del 28', 'F508del + VX-809 28'};
exp(4).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(4).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(4).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(5).plateStr			= {'28°C 5'};
exp(5).expStr       = 'Stella local VX809 28 23-11-17_Plate_15730';
exp(5).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\23-11-17';
exp(5).local_quench = 'local';
exp(5).filePrefix   = 'Stella local VX809 28 23-11-17_';

exp(5).conditionStr			= {'WT 28','F508del 28', 'F508del + VX-809 28'};
exp(5).condWells(1,1:8) = {'C02','C03','C04','C05','C06','C07','C08','C09'};
exp(5).condWells(2,1:8) = {'D02','D03','D04','D05','D06','D07','D08','D09'};
exp(5).condWells(3,1:8) = {'E02','E03','E04','E05','E06','E07','E08','E09'};

%%%%%%%%%%%%%%%%%%% LOCAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(6).plateStr			= {'28°C 6'};
exp(6).expStr       = 'Stella local VX809 28 24-11-17_Plate_15733';
exp(6).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\24-11-17';
exp(6).local_quench = 'local';
exp(6).filePrefix   = 'Stella local VX809 28 24-11-17_';

exp(6).conditionStr			= {'WT 28','F508del 28', 'F508del + VX-809 28'};
exp(6).condWells(1,1:8) = {'C02','C03','C04','C05','C06','C07','C08','C09'};
exp(6).condWells(2,1:8) = {'D02','D03','D04','D05','D06','D07','D08','D09'};
exp(6).condWells(3,1:8) = {'E02','E03','E04','E05','E06','E07','E08','E09'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(7).plateStr					= {'37°C 1'};
exp(7).expStr						= 'Stella local VX809 37degrees expensive plate 02-11-17_Plate_15663';
exp(7).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(7).local_quench			= 'local';
exp(7).filePrefix				= 'Stella local VX809 37degrees expensive plate 02-11-17_';

exp(7).conditionStr			= {'WT 37','F508del 37', 'F508del + VX-809 37'};
exp(7).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(7).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(7).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(8).plateStr			= {'37°C 2'};
exp(8).expStr       = 'Stella local VX809  02-11-17  37degrees normal plate_Plate_15660';
exp(8).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(8).local_quench = 'local';
exp(8).filePrefix   = 'Stella local VX809  02-11-17  37degrees normal plate_';

exp(8).conditionStr			= {'WT 37','F508del 37', 'F508del + VX-809 37'};
exp(8).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(8).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(8).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(9).plateStr					= {'37°C 3'};
exp(9).expStr						= 'Stella local VX809 37degrees 03-11-17 expensive plate_Plate_15676';
exp(9).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(9).local_quench			= 'local';
exp(9).filePrefix				= 'Stella local VX809 37degrees 03-11-17 expensive plate_';

exp(9).conditionStr			= {'WT 37','F508del 37', 'F508del + VX-809 37'};
exp(9).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(9).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(9).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(10).plateStr	   = {'37°C 4'};
exp(10).expStr       = 'Stella local VX809 37degrees 03-11-17 normal plate_Plate_15673 and Plate_15674';
exp(10).baseFolder	 = 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(10).local_quench = 'local';
exp(10).filePrefix   = 'Stella local VX809 37degrees 03-11-17 normal plate_';

exp(10).conditionStr			= {'WT 37','F508del 37', 'F508del + VX-809 37'};
exp(10).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(10).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(10).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(11).plateStr		 = {'37°C 5'};
exp(11).expStr       = 'Stella local VX809 37 23-11-17_Plate_15728';
exp(11).baseFolder	 = 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\23-11-17';
exp(11).local_quench = 'local';
exp(11).filePrefix   = 'Stella local VX809 37 23-11-17_';

exp(11).conditionStr			= {'WT 37','F508del 37', 'F508del + VX-809 37'};
exp(11).condWells(1,2:8) = {'C03','C04','C05','C06','C07','C08','C09'};
exp(11).condWells(2,1:8) = {'D02','D03','D04','D05','D06','D07','D08','D09'};
exp(11).condWells(3,1:8) = {'E02','E03','E04','E05','E06','E07','E08','E09'};

