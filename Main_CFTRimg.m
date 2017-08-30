clc;
clear;

tic;
% close all other windows
close all
imtool close all

% add the functions to the path
addpath(genpath('functions'));

% declare global variables
global SITEN BINNING EXTRA

BINNING = 1 / 2;
EXTRA = ceil(BINNING*20);


% runMode = 'StellaTestLocal'; % 'test' OR 'full' OR 'StellaTest'

%% IMPORT DATA

	SITEN = 9;
	inputDataLocalStellaTestICL4;
	cond = createConditionStruct(exp);
	cond = findImagePaths(exp,cond);

% if strcmp(runMode,'test')
% 	inputDataTest
% 	cond = createConditionStruct(exp);
% 	cond = findImagePaths(exp,cond);
% elseif strcmp(runMode,'full')
% 	SITEN = 9;
% 	inputData;
% 	cond = createConditionStruct(exp);
% 	cond = findImagePaths(exp,cond);
% elseif strcmp(runMode,'Stella')
% 	SITEN = 9;
% 	inputDataStellaICL4;
% 	cond = createConditionStruct(exp);
% 	cond = findImagePaths(exp,cond);
% elseif strcmp(runMode,'StellaTest')
% 	SITEN = 2;
% 	inputDataStellaTestICL4;
% 	cond = createConditionStruct(exp);
% 	cond = findImagePaths(exp,cond);
% elseif strcmp(runMode,'StellaTestQuench')
% 	SITEN = 1;
% 	inputDataQuenchStellaTestICL4;
% 	cond = createConditionStruct(exp);
% 	cond = findImagePaths(exp,cond);
% elseif strcmp(runMode,'StellaTestLocal')
% 	SITEN = 1;
% 	inputDataLocalStellaTestICL4;
% 	cond = createConditionStruct(exp);
% 	cond = findImagePaths(exp,cond);
% end

conditionN = length(cond);

disp('Completed importing data')
time(1) = toc;
%% SEGMENTATION

close all

for j=1:conditionN
 	for i=1:cond(j).localImageN

		cond(j).imageLocal(i) = imgSegmentWatershed(cond(j).imageLocal(i));

	end
end

store = cond;

disp('Completed image segmentation')
time(2) = toc;
%% FILTERING

cond = store;

for j=1:conditionN
	for i=1:cond(j).localImageN
		
		cond(j).imageLocal(i).cellN = cond(j).imageLocal(i).cellN(1);
		
		cond(j).imageLocal(i) = imgFilterEdges(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFilterUnmasked(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFilterCellDimensions(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFilterRedGrad(cond(j).imageLocal(i));
		
	end
end

disp('Completed cell filtering')
time(3) = toc;
%% DISTANCE MAP

for j=1:conditionN
	for i=1:cond(j).localImageN
		
		cond(j).imageLocal(i) = imgFindBackground(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = distanceMap(cond(j).imageLocal(i));

	end
end

disp('Completed localisation distance map')
time(4) = toc;
%% QUENCHING ANALYSIS

for j=1:conditionN
	
	quenchImageN = cond(j).quenchImageTestN + cond(j).quenchImageControlN;
	
	for i=1:quenchImageN
		
		cond(j).imageQuench(i) = findRedMaskChange(cond(j).imageQuench(i));
		
		cond(j).imageQuench(i) = findYelInsideOverTime(cond(j).imageQuench(i));
		
		cond(j).imageQuench(i) = calculateConcIodine(cond(j).imageQuench(i));
		
	end
end

disp('Completed quenching analysis')
time(5) = toc;
%%

disp('Full analysis completed')

save('./al.mat')
