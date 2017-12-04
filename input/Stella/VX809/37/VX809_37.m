%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                WT  F508del  F508del+VX-809			  						 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%																																 %%%	
%%%   to check whether the mCh.YFP assay can measure rescue of     %%%
%%%   F508del mislocalisation by temp correction and/or VX-809     %%%
%%%																																 %%%	
%%%								      37°C	   10uM VX-809		  								 %%%	
%%%																																 %%%	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 6 ;
exp					= createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% LOCALISATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(1).plateStr					= {'37°C 1'};
exp(1).expStr						= 'Stella local VX809 37degrees expensive plate 02-11-17_Plate_15663';
exp(1).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(1).local_quench			= 'local';
exp(1).filePrefix				= 'Stella local VX809 37degrees expensive plate 02-11-17_';

exp(1).conditionStr			= {'WT','F508del', 'F508del + VX-809'};
exp(1).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(1).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(1).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(2).plateStr			= {'37°C 2'};
exp(2).expStr       = 'Stella local VX809  02-11-17  37degrees normal plate_Plate_15660';
exp(2).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(2).local_quench = 'local';
exp(2).filePrefix   = 'Stella local VX809  02-11-17  37degrees normal plate_';

exp(2).conditionStr			= {'WT','F508del', 'F508del + VX-809'};
exp(2).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(2).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(2).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(3).plateStr					= {'37°C 3'};
exp(3).expStr						= 'Stella local VX809 37degrees 03-11-17 expensive plate_Plate_15676';
exp(3).baseFolder				= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(3).local_quench			= 'local';
exp(3).filePrefix				= 'Stella local VX809 37degrees 03-11-17 expensive plate_';

exp(3).conditionStr			= {'WT','F508del', 'F508del + VX-809'};
exp(3).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(3).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(3).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(4).plateStr			= {'37°C 4'};
exp(4).expStr       = 'Stella local VX809 37degrees 03-11-17 normal plate_Plate_15673 and Plate_15674';
exp(4).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(4).local_quench = 'local';
exp(4).filePrefix   = 'Stella local VX809 37degrees 03-11-17 normal plate_';

exp(4).conditionStr			= {'WT','F508del', 'F508del + VX-809'};
exp(4).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(4).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(4).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% QUENCHING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(5).plateStr			= {'37°C 5'};
exp(5).expStr       = 'Stella quenching 02-11-2017 37degrees VX809_Plate_15662';
exp(5).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(5).local_quench = 'quench';
exp(5).filePrefix		= 'Stella quenching 02-11-2017 37degrees VX809_';
exp(5).conditionStr	= {'WT','F508del', 'F508del + VX-809'};

exp(5).condWells(1,1:3) = {'B02','C02','D02'};
exp(5).condWells(2,1:3) = {'B03','C03','D03'};
exp(5).condWells(3,1:3) = {'B04','C04','D04'};

exp(5).condWellsControl(1,1:3) = {'E02','F02','G02'};
exp(5).condWellsControl(2,1:3) = {'E03','F03','G03'};
exp(5).condWellsControl(3,1:3) = {'E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(6).plateStr			= {'37°C 6'};
exp(6).expStr       = 'Stella quench VX809 37degrees 03-11-2017_Plate_15675';
exp(6).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(6).local_quench = 'quench';
exp(6).filePrefix		= 'Stella quench VX809 37degrees 03-11-2017_';
exp(6).conditionStr	= {'WT','F508del', 'F508del + VX-809'};

exp(6).condWells(1,1:3) = {'B02','C02','D02'};
exp(6).condWells(2,1:3) = {'B03','C03','D03'};
exp(6).condWells(3,1:3) = {'B04','C04','D04'};

exp(6).condWellsControl(1,1:3) = {'E02','F02','G02'};
exp(6).condWellsControl(2,1:3) = {'E03','F03','G03'};
exp(6).condWellsControl(3,1:3) = {'E04','F04','G04'};

