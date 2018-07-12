
desktopDir = getDesktopDir();
saveWorkspaceHere = fullfile(desktopDir,'example_quench');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inputFolderN	= 1;																		% number of input folders
input					= createInputStruct_quench(inputFolderN);	% create empty structs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input(1).plateStr						= {'plate1'};			% string labelling the plate
input(1).experimentStr			= {'exp1'};				% string for grouping plates

	input(1).folderName				= 'plate1_quench'; % name of the data folder
	input(1).baseFolder				= fullfile('example','data'); % path of data folder
	input(1).filePrefix				= 'plate1_quench_'; % filename of each image before B02_etc
	
	input(1).conditionStr			= {'WT','F508del'};
		input(1).condWells(1,1:2) = {'B02','E02'}; % the wells for cond 1, 'WT'
		input(1).condWells(2,1:2) = {'B03','E03'}; % the wells for cond 2, 'F508del'
		input(1).condWellsControl(1,1) = {'E02'}; % the control wells for cond 1, 'WT'
		input(1).condWellsControl(2,1) = {'E03'}; % the control wells for cond 2, 'F508del'
		
	input(1).timeStep		= 2; % time between image collection (seconds)
	input(1).timeline		= [5,26,70];	% [first addition , second addition, end] (timepoints)
																		% [normalize time, start of interest, end] (timepoints)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%