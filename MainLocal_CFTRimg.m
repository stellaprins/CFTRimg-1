
clc
clear
close all

addpath(genpath('functions'))

addpath(genpath(fullfile('example','input'))) % location of your input folder
example_local % the name of your input file

%% STRUCTURING DATA
tic
exp		= createExpStruct(plate);			% creates an empty struct for each plate
exp		= findImagePaths(plate,exp);	% collects the path names for each image
expN	= length(exp);								% and creates a struct for each image

disp('Completed setting up data structures')
time(1) = toc;

%% SEGMENTATION
close all
for j = 1:expN
	localImageN = length(exp(j).imageLocal);
	for i = 1:localImageN
		exp(j).imageLocal(i) = imgSegmentWatershed(exp(j).imageLocal(i));
	end
end
store		= exp;
disp		('Completed image segmentation')
time(2)	= toc;

%% FILTERING
exp = store;
for j = 1:expN
	localImageN = length(exp(j).imageLocal);
	for i = 1:localImageN
		exp(j).imageLocal(i).cellN = exp(j).imageLocal(i).cellN(1);
 		exp(j).imageLocal(i) = imgFilterEdges(exp(j).imageLocal(i));
 		exp(j).imageLocal(i) = imgFilterUnmasked(exp(j).imageLocal(i));
		exp(j).imageLocal(i) = imgFilterCellDimensions(exp(j).imageLocal(i));
	end
end
disp		('Completed cell filtering')
time(3) = toc;

%% DISTANCE MAP
	for j = 1:expN
		localImageN = length(exp(j).imageLocal);
		for i = 1:localImageN
			exp(j).imageLocal(i) = imgFindBackground(exp(j).imageLocal(i));
			exp(j).imageLocal(i) = distanceMap(exp(j).imageLocal(i));
		end
	end
disp		('Completed localization distance maps')
time(4) = toc;

%% CREATE RESULTS STRUCTS
for j=1:expN
	localImageN = length(exp(j).imageLocal);
	for i=1:localImageN
		exp(j).imageLocal(i) = filterNegativeMetric(exp(j).imageLocal(i));
		exp(j).imageLocal(i) = logCellLocation(exp(j).imageLocal(i),j,i);
	end
end

% move key values into temporary a structure for normalizing
tempResultsLocal = createNormalizeStruct(exp,normConditionStr);
tempResultsLocal = normalizeResultsWT(tempResultsLocal,normConditionStr);

% move normalized results into a structure ready to output results
resultsLocal = createResultsLocalStruct(tempResultsLocal);
resultsLocal = populateResultsLocal(resultsLocal,tempResultsLocal);
		
time(5)				= toc;

disp					('Full analysis completed')
save					(saveWorkspaceHere)
