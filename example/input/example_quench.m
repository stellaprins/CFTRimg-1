
saveWorkspaceHere = fullfile('~','Desktop','example_quench');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plateN	= 1; % number of plates
plate		= createPlateStruct(plateN);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plate(1).experimentStr  = {'1'};
plate(1).plateStr				= {'exp1 37'};
plate(1).normConditionStr	= {};

	plate(1).local_quench = 'quench';
	plate(1).localBinning			= 0; % set as zero if not applicable
	plate(1).localSiteN				= 0;
	plate(1).quenchTimeStep		= 2; % time between image collection (seconds)
	plate(1).quenchTimeline		= [5,26,70];	% [first addition , second addition, end] (timepoints)
																					% [normalize time, start of interest, end] (timepoints)

	plate(1).folderName   = 'plate1_quench'; 
	plate(1).baseFolder	  = fullfile('example','data');
	plate(1).filePrefix   = 'plate1_quench_';

	plate(1).conditionStr = {'WT 37','F508del 37'};
		plate(1).condWells(1,1) = {'B02'};
		plate(1).condWells(2,1) = {'B03'};
		plate(1).condWellsControl(1,1) = {'E02'};
		plate(1).condWellsControl(2,1) = {'E03'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%