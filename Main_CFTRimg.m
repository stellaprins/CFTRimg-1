
% close all other windows
close all
imtool close all

% add the functions to the path
addpath(genpath('functions'));

global BINNING EXTRA

BINNING = 1 / 1;
EXTRA = ceil(BINNING*15);

%% TEST IMPORT

experiment = 'exp1';
magnification = '60x';

% Set the directory in which data is stored
fileFolder = fullfile('~','Desktop','data',experiment,magnification);

dirOutput = dir(fullfile(fileFolder,'exp1_60x_B02_s*_w2.TIF'));
fileNames = {dirOutput.name}';
imageN = numel(fileNames);

pathArray = cell(9,1);
for p = 1:imageN
	pathArray{p} = fullfile(fileFolder,fileNames{p});
end

images = createImageStruct(pathArray);

%% SEGMENTATION

close all

for i=1:imageN
	
	images(i).cellN = [];
	
	images(i) = imgSegment(images(i));
	
	images(i) = imgFilterEdges(images(i));
	
	images(i) = cellBinarize(images(i));
	
 	images(i) = imgFilterCellSize(images(i));
	
% 	images(i).cellN
	
end


%% PROCESSING



%% RESULTS

close all

images(2).cellN
imgDisplay(images(2))
for i=1:images(2).cellN(end)
	figure
	cellDisplay(images(2),i)
end
