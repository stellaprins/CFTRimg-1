%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentN = 1; % number of plates
exp         = createExperimentStruct(experimentN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% NO TEMP CORRECTION %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp(1).plateStr     = {'plate 1'};
exp(1).expStr       = 'Emily H quenching 13-10-2017 37 degrees c_Plate_15626'; % name of the folder in which the data is
exp(1).baseFolder		= 'L:\Emily H'; %filepath need to check
exp(1).local_quench = 'quench'; % either 'local' or 'quench' depending on the experiment type
exp(1).filePrefix   = 'Emily H quenching 13-10-2017 37 degrees c_'; % filename before B02_etc

exp(1).conditionStr = {'WT','F508del','F508del/R1070W',...
	'F508del/A141S','F508del/R1097T'};

%% FORSKOLIN
exp(1).condWells(1,1:3) = {'B02','C02','D02'}; % delete the wells that we didn't record
exp(1).condWells(2,1:3) = {'B03','C03','D03'};
exp(1).condWells(3,1:3) = {'B04','C04','D04'};
exp(1).condWells(4,1:3) = {'B05','C05','D05'};
exp(1).condWells(5,1:3) = {'B06','C06','D06'};


%% DMSO (Control)
exp(1).condWellsControl(1,1:3) = {'E02','F02','G02'};
exp(1).condWellsControl(2,1:3) = {'E03','F03','G03'};
exp(1).condWellsControl(3,1:3) = {'E04','F04','G04'};
exp(1).condWellsControl(4,1:3) = {'E05','F05','G05'};
exp(1).condWellsControl(5,1:3) = {'E06','F06','G06'};

