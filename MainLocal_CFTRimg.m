clc
clear
addpath(genpath('functions'))
addpath(genpath(fullfile('~/Desktop/CFTR/input'))) %% include the location of your input folder

%%

VX809_28_37_LOCAL_test % the name of your input file
saveWorkspaceHere = 'C:\Users\StellaPrins\Desktop\VX809_28_37_LOCAL_test 31-05-18';
normConditionStr1	= 'WT 37'; % (resultsLocal1)
normConditionStr2	= 'WT 28'; % (resultsLocal2)


%%
close all
imtool close all
global SITEN BINNING EXTRA

SITEN		= 4;
BINNING = 1/2;	% 1/2 for 2*2
EXTRA		= ceil(BINNING*20);


%% STRUCTURING DATA
tic
plate		= createPlateStruct(exp);			% creates an empty struct for each plate
plate		= findImagePaths(exp,plate);	% collects the path names for each image
plateN	= length(plate);							% and creates a struct for each image
disp('Completed setting up data structures')
time(1) = toc;

%% SEGMENTATION
close all
for j = 1:plateN
	localImageN = length(plate(j).imageLocal);
	for i = 1:localImageN
		plate(j).imageLocal(i) = imgSegmentWatershed(plate(j).imageLocal(i));
	end
end
store		= plate;
disp		('Completed image segmentation')
time(2)	= toc;

%% FILTERING
plate = store;
for j = 1:plateN
	localImageN = length(plate(j).imageLocal);
	for i = 1:localImageN
		plate(j).imageLocal(i).cellN = plate(j).imageLocal(i).cellN(1);
 		plate(j).imageLocal(i) = imgFilterEdges(plate(j).imageLocal(i));
 		plate(j).imageLocal(i) = imgFilterUnmasked(plate(j).imageLocal(i));
		plate(j).imageLocal(i) = imgFilterCellDimensions(plate(j).imageLocal(i));
	end
end
disp		('Completed cell filtering')
time(3) = toc;

%% DISTANCE MAP
	for jj = 1:plateN
			for ii = 1:localImageN
				plate(jj).imageLocal(ii).yelMembraneAbsolute =[];
				plate(jj).imageLocal(ii).yelEntireAbsolute =[];	
				plate(jj).imageLocal(ii).redEntireAbsolute =[];	
			end
	end
	for j = 1:plateN
		localImageN = length(plate(j).imageLocal);
		for i = 1:localImageN
			plate(j).imageLocal(i) = imgFindBackground(plate(j).imageLocal(i));
			plate(j).imageLocal(i) = distanceMap(plate(j).imageLocal(i));
		end
	end
disp		('Completed localisation distance maps')
time(4) = toc;

%% CREATE RESULTS STRUCTS
% filter any cells giving a negative metric (yelMembrane/redEntire)
for j=1:plateN
	localImageN = length(plate(j).imageLocal);
	for i=1:localImageN
		plate(j).imageLocal(i) = filterNegativeMetric(plate(j).imageLocal(i));
	end
end
% log the location of each cell (plate index, temperature, image index and bounding box index)so that the cells can be found later for image display
for j=1:plateN
	localImageN = length(plate(j).imageLocal);
	for i=1:localImageN
		plate(j).imageLocal(i) = logCellLocation(plate(j).imageLocal(i),j,i);
	end
end
% move key values into temporary a structure for normalizing
normConditionStr = normConditionStr1;
tempResultsLocal = createNormalizeStruct(plate);
		for i = 1:plateN		
			tempResultsLocal(i) = normalizeResultsWT(tempResultsLocal(i),normConditionStr); % normalise results to normConditionStr1
		end
		resultsLocal	= createResultsLocalStruct(tempResultsLocal);
		resultsLocal1	= populateResultsLocal(resultsLocal,tempResultsLocal);

if ~isempty(normConditionStr2) %only if a condition is filled in in normConditionStr2 a second resultsLocal will be made normalised to normCondtionStr2
		normConditionStr = normConditionStr2;
		tempResultsLocal = createNormalizeStruct(plate);
		for i = 1:plateN		
			tempResultsLocal(i) = normalizeResultsWT(tempResultsLocal(i),normConditionStr); % normalise results to normConditionStr2
		end
		resultsLocal	= createResultsLocalStruct(tempResultsLocal);
		resultsLocal2	= populateResultsLocal(resultsLocal,tempResultsLocal);
end
		
time(5)				= toc;

disp					('Full analysis completed')
save					(saveWorkspaceHere)
