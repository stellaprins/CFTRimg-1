clc;
clear;
addpath(genpath('functions'));
addpath(genpath('input'));
%% 
inputDataTestKatie
% inputDataQuenchStellaTestICL4; %the name of your input file
saveWorkspaceHere = './quench23102017.mat';

%%
tic;
close all
imtool close all
global SITEN BINNING EXTRA
BINNING = 1 / 1;
EXTRA = ceil(BINNING*20);

%% IMPORT DATA
	SITEN = 1;
	cond = createConditionStruct(exp);
	cond = findImagePaths(exp,cond);
conditionN = length(cond);
disp('Completed importing conditions')
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
disp('Completed localisation distance maps')
time(4) = toc;

%% QUENCHING ANALYSIS
for j=1:conditionN;
	quenchImageN = cond(j).quenchImageTestN + cond(j).quenchImageControlN;
	for i=1:quenchImageN;
		cond(j).imageQuench(i) = findRedMaskChange(cond(j).imageQuench(i));
		cond(j).imageQuench(i) = findYelInsideOverTime(cond(j).imageQuench(i));
		cond(j).imageQuench(i) = calculateConcIodine(cond(j).imageQuench(i));
	end
end
disp('Completed quenching analysis');
time(5) = toc;

%%

disp('Full analysis completed')
save(saveWorkspaceHere)
