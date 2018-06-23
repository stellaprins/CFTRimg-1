
saveWorkspaceHere = fullfile('~','Desktop','example_local');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plateN	= 3; % number of plates
plate		= createPlateStruct(plateN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plate(1).experimentStr		= {'1'};
plate(1).plateStr					= {'exp1 37'};
plate(1).normConditionStr	= {'WT 37'};

	plate(1).local_quench = 'local';
	plate(1).localBinning			= 1/2; % for 2*2 binning
	plate(1).localSiteN				= 1; % number of image sites per well
	plate(1).quenchTimeStep		= 0; % set as zero if not applicable
	plate(1).quenchTimeline		= 0;

	plate(1).folderName   = 'plate1_local'; % name of the folder in which the data is	
	plate(1).baseFolder	  = fullfile('example','data'); % filepath need to check
	plate(1).filePrefix   = 'plate1_local_'; % filename before B02_etc

	plate(1).conditionStr = {'WT 37','F508del 37'};
		plate(1).condWells(1,1:2) = {'B02','E02'}; % delete the wells that we didn't record
		plate(1).condWells(2,1:2) = {'B03','E03'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

plate(2).experimentStr		= {'2'};
plate(2).plateStr					= {'exp2 37'};
plate(2).normConditionStr	= {'WT 37'};

	plate(2).local_quench = 'local';
	plate(2).localBinning			= 1/2; % for 2*2 binning
	plate(2).localSiteN				= 1;
	plate(2).quenchTimeline		= 0; % set as zero if not applicable
	plate(2).quenchFrequency	= 0;

	plate(2).folderName		= 'plate2a_local';
	plate(2).baseFolder	  = fullfile('example','data');
	plate(2).filePrefix   = 'plate2_local_';

	plate(2).conditionStr = {'WT 37','F508del 37'};
		plate(2).condWells(1,1) = {'B02'};
		plate(2).condWells(2,1) = {'B03'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plate(3).experimentStr		= {'2'};
plate(3).plateStr					= {'exp2 37'};
plate(3).normConditionStr	= {'WT 37'};

	plate(3).local_quench = 'local';
	plate(3).localBinning			= 1/2; % for 2*2 binning
	plate(3).localSiteN				= 1;
	plate(3).quenchTimeline		= 0; % set as zero if not applicable
	plate(3).quenchFrequency	= 0;

	plate(3).folderName   = 'plate2b_local';
	plate(3).baseFolder	  = fullfile('example','data');
	plate(3).filePrefix   = 'plate2_local_';

	plate(3).conditionStr = {'WT 37'};
		plate(3).condWells(1,1) = {'E02'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
