
% close all other windows
close all
imtool close all

% add the functions to the path
addpath(genpath('functions'));

global BINNING EXTRA

BINNING = 1 / 1;
EXTRA = ceil(BINNING*20);

%% TEST IMPORT

experiment = 'exp1';
magnification = '60x';

% Set the directory in which data is stored
fileFolder = fullfile('~','Desktop','data',experiment,magnification);

redDirOutput = dir(fullfile(fileFolder,'exp1_60x_B02_s*_w2.TIF'));
yelDirOutput = dir(fullfile(fileFolder,'exp1_60x_B02_s*_w1.TIF'));
redFileNames = {redDirOutput.name}';
yelFileNames = {yelDirOutput.name}';

imageN = numel(redFileNames);

redPathArray = cell(9,1);
yelPathArray = cell(9,1);
for p = 1:imageN
	redPathArray{p} = fullfile(fileFolder,redFileNames{p});
	yelPathArray{p} = fullfile(fileFolder,yelFileNames{p});
end

images = createImageStruct(redPathArray,yelPathArray);

%% SEGMENTATION

close all

for i=1:imageN
	
	images(i).cellN = [];
	
	images(i) = imgSegment(images(i));
	
	images(i) = imgFilterEdges(images(i));
	
	images(i) = findCellDimensions(images(i));
	
 	images(i) = imgFilterCellSize(images(i));
	
% 	images(i).cellN
	
end


%% PROCESSING



%% RESULTS

close all

x=3;

images(x).cellN
imgDisplay(images(x))
for i=1:images(x).cellN(end)
	figure
	cellDisplay(images(x),i)
end
