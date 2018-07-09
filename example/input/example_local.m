
desktopDir = getDesktopDir();
saveWorkspaceHere = fullfile(desktopDir,'example_local');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inputFolderN	= 3;																		% number of input folders
input					= createInputStruct_local(inputFolderN);	% create empty structs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input(1).plateStr						= {'plate1'};			% string labelling the plate
input(1).experimentStr			= {'exp1'};				% string for grouping plates

	input(1).folderName				= 'plate1_local'; % name of the data folder
	input(1).baseFolder				= fullfile('example','data'); % path of data folder
	input(1).filePrefix				= 'plate1_local_'; % filename of each image before B02_etc
	
	input(1).conditionStr			= {'WT','F508del'};
		input(1).condWells(1,1:2) = {'B02','E02'}; % the wells for cond 1, 'WT'
		input(1).condWells(2,1:2) = {'B03','E03'}; % the wells for cond 2, 'F508del'
		
	input(1).normConditionStr	= {'WT'};				% condition to normalize to
	input(1).pixelBinning			= 1/2;					% 1/2 for 2*2 pixel binning
	input(1).siteN						= 1;						% number of image sites per well

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

input(2).plateStr						= {'plate2'};
input(2).experimentStr			= {'exp2'};

	input(2).folderName				= 'plate2a_local';
	input(2).baseFolder				= fullfile('example','data');
	input(2).filePrefix				= 'plate2_local_';

	input(2).conditionStr			= {'WT','F508del'};
		input(2).condWells(1,1)		= {'B02'};
		input(2).condWells(2,1)		= {'B03'};
		
	input(2).normConditionStr	= {'WT'};
	input(2).pixelBinning			= 1/2;
	input(2).siteN						= 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input(3).plateStr						= {'plate2'};
input(3).experimentStr			= {'exp2'};

	input(3).folderName				= 'plate2b_local';
	input(3).baseFolder				= fullfile('example','data');
	input(3).filePrefix				= 'plate2_local_';

	input(3).conditionStr			= {'WT'};
		input(3).condWells(1,1)		= {'E02'};
		
	input(3).normConditionStr	= {'WT'};
	input(3).pixelBinning			= 1/2;
	input(3).siteN						= 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
