
% close all other windows
close all
imtool close all

% add the functions to the path
addpath(genpath('functions'));

%% TEST

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

%% PROCESSING

close all

for i=1:imageN
	
	images(i) = imgSegment(images(i));
	
	images(i) = imgFilter(images(i));
	
end

% figure
% imtool(out,[])

%% RESULTS


