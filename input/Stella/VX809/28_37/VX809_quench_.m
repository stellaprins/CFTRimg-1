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

experimentN = 7 ;
exp					= createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% QUENCHING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(1).plateStr			= {'28°C 1'};
exp(1).expStr       = 'Stella quenching 02-11-2017 TEMP CORRECT normal plate_Plate_15658';
exp(1).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(1).local_quench = 'quench';
exp(1).filePrefix		= 'Stella quenching 02-11-2017 TEMP CORRECT normal plate_';
exp(1).conditionStr	= {'WT 28°C','F508del 28°C', 'F508del + VX-809 + VX-770 28°C'};

exp(1).condWells(1,1:3) = {'B02','C02','D02'};
exp(1).condWells(2,1:3) = {'B03','C03','D03'};
exp(1).condWells(3,1:3) = {'B04','C04','D04'};

exp(1).condWellsControl(1,1:3) =  {'E02','F02','G02'};
exp(1).condWellsControl(2,1:3) = {'E03','F03','G03'};
exp(1).condWellsControl(3,1:3) = {'E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(2).plateStr			= {'28°C 2'};
exp(2).expStr       = 'Stella quench VX809 temp correct 13-10-2017_Plate_15671';
exp(2).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(2).local_quench = 'quench';
exp(2).filePrefix		= 'Stella quench VX809 temp correct 13-10-2017_';
exp(2).conditionStr	= {'WT 28°C','F508del 28°C', 'F508del + VX-809 + VX-770 28°C'};

exp(2).condWells(1,1:3) = {'B02','C02','D02'};
exp(2).condWells(2,1:3) = {'D03','B03','C03'};
exp(2).condWells(3,1:3) = {'B04','C04','D04'};

exp(2).condWellsControl(1,1:3) =  {'E02','F02','G02'};
exp(2).condWellsControl(2,1:3) = {'E03','F03', 'G03'}; 
exp(2).condWellsControl(3,1:3) = {'E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(3).plateStr			= {'37°C 1'};
exp(3).expStr       = 'Stella quenching 02-11-2017 37degrees VX809_Plate_15662';
exp(3).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17';
exp(3).local_quench = 'quench';
exp(3).filePrefix		= 'Stella quenching 02-11-2017 37degrees VX809_';
exp(3).conditionStr	= {'WT 37°C','F508del 37°C', 'F508del + VX-809 + VX-770 37°C'};

exp(3).condWells(1,1:3) = {'B02','C02','D02'};
exp(3).condWells(2,1:3) = {'B03','C03','D03'};
exp(3).condWells(3,1:3) = {'B04','C04','D04'};

exp(3).condWellsControl(1,1:3) =  {'E02','F02','G02'};
exp(3).condWellsControl(2,1:3) = {'E03','F03','G03'};
exp(3).condWellsControl(3,1:3) = {'E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(4).plateStr			= {'37°C 2'};
exp(4).expStr       = 'Stella quench VX809 37degrees 03-11-2017_Plate_15675';
exp(4).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\03-11-17';
exp(4).local_quench = 'quench';
exp(4).filePrefix		= 'Stella quench VX809 37degrees 03-11-2017_';
exp(4).conditionStr	= {'WT 37°C','F508del 37°C', 'F508del + VX-809 + VX-770 37°C'};

exp(4).condWells(1,1:3) = {'B02','C02','D02'};
exp(4).condWells(2,1:3) = {'B03','C03','D03'};
exp(4).condWells(3,1:3) = {'B04','C04','D04'};

exp(4).condWellsControl(1,1:3) =  {'E02','F02','G02'};
exp(4).condWellsControl(2,1:3) = {'E03','F03','G03'};
exp(4).condWellsControl(3,1:3) = {'E04','F04','G04'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(5).plateStr			= {'28°C 3'};
exp(5).expStr       = 'Stella quench VX809 28 23-11-17_Plate_15731';
exp(5).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\23-11-17';
exp(5).local_quench = 'quench';
exp(5).filePrefix		= 'Stella quench VX809 28 23-11-17_';
exp(5).conditionStr	= {'WT + VX-770 28°C', 'F508del + VX-770 28°C', 'F508del + VX-809 + VX-770 28°C'};

exp(5).condWells(1,1:4) = {'C02','C04','C06','C08'};
exp(5).condWells(2,1:4) = {'D02','D04','D06','D08'};
exp(5).condWells(3,1:4) = {'E02','E04','E06','E08'};

exp(5).condWellsControl(1,1:4) =  {'C03','C05','C07','C09'};
exp(5).condWellsControl(2,1:4) =  {'D03','D05','D07','D09'};
exp(5).condWellsControl(3,1:4) =  {'E03','E05','E07','E09'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(6).plateStr			= {'37°C 3'};
exp(6).expStr       = 'Stella quench VX809 37 23-11-17_Plate_15729';
exp(6).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\23-11-17';
exp(6).local_quench = 'quench';
exp(6).filePrefix		= 'Stella quench VX809 37 23-11-17_';
exp(6).conditionStr	= {'WT + VX-770 37°C', 'F508del + VX-770 37°C', 'F508del + VX-809 + VX-770 37°C'};

exp(6).condWells(1,1:4) = {'C02','C04','D06','C08'};
exp(6).condWells(2,1:4) = {'D02','D04','D06','D08'};
exp(6).condWells(3,1:4) = {'E02','E04','D06','E08'};

exp(6).condWellsControl(1,1:4) =  {'C03','C05','C07','C09'};
exp(6).condWellsControl(2,1:4) =  {'D03','D05','D07','D09'};
exp(6).condWellsControl(3,1:4) =  {'E03','E05','E07','E09'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(7).plateStr			= {'28°C 4'};
exp(7).expStr       = 'Stella quench VX809 28 24-11-2017_Plate_15734';
exp(7).baseFolder		= 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\24-11-17';
exp(7).local_quench = 'quench';
exp(7).filePrefix		= 'Stella quench VX809 28 24-11-2017_';
exp(7).conditionStr	= {'WT + VX-770 28°C', 'F508del + VX-770 28°C', 'F508del + VX-809 + VX-770 28°C'};

exp(7).condWells(1,1:4) = {'C02','C04','C06','C08'};
exp(7).condWells(2,1)		= {'D08'};
exp(7).condWells(3,1:4) = {'E02','E04','E06','E08'};

exp(7).condWellsControl(1,1:4) =  {'C03','C05','C07','C09'};
exp(7).condWellsControl(2,1:4) =  {'D03','D05','D07','D09'};
exp(7).condWellsControl(3,1:4) =  {'E03','E05','E07','E09'};




