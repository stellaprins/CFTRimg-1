clc;
clear;
addpath(genpath('functions'));
addpath(genpath('input'));
%%
inputDataTestKatie; % the name of your input file
saveWorkspaceHere = './quench23102017.mat';

%%
tic
close all
imtool close all
global SITEN BINNING EXTRA
BINNING = 1 / 1;
EXTRA = ceil(BINNING*20);

%% STRUCTURING DATA
	SITEN = 1;
	plate = createPlateStruct(exp); % creates an empty struct for each plate
	plate = findImagePaths(exp,plate);	% collects the path names for each image
																			% and creates a struct for each image
	
	plateN = length(plate);
	
	
disp('Completed setting up data structures')
time(1) = toc;

%% SEGMENTATION
close all
for j=1:plateN
	localImageN = length(plate(j).imageLocal);
 	for i=1:localImageN
		plate(j).imageLocal(i) = imgSegmentWatershed(plate(j).imageLocal(i));
	end
end
store = plate;
disp('Completed image segmentation')
time(2) = toc;

%% FILTERING
plate = store;
for j=1:plateN
	localImageN = length(plate(j).imageLocal);
 	for i=1:localImageN
		plate(j).imageLocal(i).cellN = plate(j).imageLocal(i).cellN(1);
		plate(j).imageLocal(i) = imgFilterEdges(plate(j).imageLocal(i));
		plate(j).imageLocal(i) = imgFilterUnmasked(plate(j).imageLocal(i));
		plate(j).imageLocal(i) = imgFilterCellDimensions(plate(j).imageLocal(i));
		plate(j).imageLocal(i) = imgFilterRedGrad(plate(j).imageLocal(i));
	end
end
disp('Completed cell filtering')
time(3) = toc;

%% DISTANCE MAP
for j=1:plateN
	localImageN = length(plate(j).imageLocal);
 	for i=1:localImageN
		plate(j).imageLocal(i) = imgFindBackground(plate(j).imageLocal(i));
		plate(j).imageLocal(i) = distanceMap(plate(j).imageLocal(i));
	end
end
disp('Completed localisation distance maps')
time(4) = toc;

%% QUENCHING ANALYSIS
for j=1:plateN
	quenchImageN = size(plate(j).imageQuench,1);
 	for i=1:quenchImageN
		plate(j).imageQuench(i) = findRedMaskChange(plate(j).imageQuench(i));
		plate(j).imageQuench(i) = findYelInsideOverTime(plate(j).imageQuench(i));
		plate(j).imageQuench(i) = calculateConcIodine(plate(j).imageQuench(i));
	end
end
disp('Completed quenching analysis');
time(5) = toc;

%% CREATE RESULTS STRUCTS

resultsLocal	= createResultsLocalStruct(plate);
resultsQuench = createResultsQuenchStruct(plate);

% for i=1:length(resultsLocal)
% 	resultsLocal(i) = filterNegativeMetric(resultsLocal(i));
% end


disp('Full analysis completed')
save(saveWorkspaceHere)
