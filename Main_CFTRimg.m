
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

Ired = imread(fileNames{1});
sequence = zeros([size(Ired) imageN],'double');
sequence(:,:,1) = Ired;

for p = 2:imageN
    sequence(:,:,p) = imread(fileNames{p});
end

%% CREATE DATA STRUCTURES

conditionsStr = {'WT','F508del','R1070W'};

cond = createConditions(conditionsStr);

% set the wells for each condition
cond(1).wells = {'B02','C02','D02','E02','F02','G02'};
cond(2).wells = {'B03','C03','D03','E03','F03','G03'};
cond(3).wells = {'B04','C04','D04','E04','F04','G04'};

conditionsN = length(cond);

%% IMPORT THE DATA

experiment = 'exp1';
magnification = '60x';
filePrefix = strcat(experiment,'_',magnification,'_');

% Set the directory in which data is stored
directory = fullfile('~','Desktop','data',experiment,'/',magnification,'/');

cond(i).redFiles = {};
cond(i).yelFiles = {};

for i=1:conditionsN
	for j=1:length(cond(i).wells)
		
		% red
		filename = strcat(filePrefix,cond(i).wells{j},'_s*_w2.TIF');
		dirOutput = dir(fullfile(directory,filename));
		
		cond(i).redFiles = ...
			vertcat(cond(i).redFiles,{dirOutput.name}');
		
		% yellow
		filename = strcat(filePrefix,cond(i).wells{j},'_s*_w1.TIF');
		dirOutput = dir(fullfile(directory,filename));
		cond(i).yelFiles = ...
			vertcat(cond(i).yelFiles,{dirOutput.name}');
		
	end
	
	cond(i).imageN = numel(cond(i).redFiles);
	
	Ired = imread(cond(i).redFiles{1});
	cond(i).redImages = zeros([size(Ired) cond(i).imageN],'double');
	cond(i).redImages(:,:,1) = Ired;
	
	Iyel = imread(cond(i).yelFiles{1});
	cond(i).yelImages = zeros([size(Iyel) cond(i).imageN],'double');
	cond(i).yelImages(:,:,1) = Iyel;
	
end

%% PROCESSING

close all

image = sequence(:,:,1);

[out] = imgSegment(image);

% figure
% imtool(out,[])

%% RESULTS