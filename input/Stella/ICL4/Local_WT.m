%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                WT  F508del  F508del+VX-809			  						 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   to check whether the mCh.YFP assay can measure rescue of     %%% 
%%%   F508del mislocalisation by temp correction and/or VX-809     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 1 ;
exp					= createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp(1).plateStr					= {'Plate 1'};
exp(1).expStr           = 'Stella localisation 60x temp corrected VX809 expensive plate_Plate_15659';
exp(1).baseFolder       = 'C:\Users\StellaPrins\Documents\DATA\Stella\VX809\02-11-17\Stella localisation 60x temp corrected VX809 expensive plate_Plate_15659';
exp(1).local_quench     = 'local';
exp(1).filePrefix       = 'Stella localisation 60x temp corrected VX809 expensive plate_Plate_15659_';
exp(1).conditionStr			= {'WT 28','F508del', 'F508del + VX-809'}

exp(1).condWells(1,1:6) = {'B02','C02','D02','E02','F02','G02'};
exp(1).condWells(2,1:6) = {'B03','C03','D03','E03','F03','G03'};
exp(1).condWells(3,1:6) = {'B04','C04','D04','E04','F04','G04'};




