
% close all other windows
close all
imtool close all

% add the functions to the path
addpath(genpath('functions'));

global SITEN BINNING EXTRA

BINNING = 1 / 1;
EXTRA = ceil(BINNING*20);

runMode = 'test'; % 'test' OR 'full'

%% IMPORT DATA

if strcmp(runMode,'test')
	SITEN = 2;
	inputDataTest
	cond = createConditionStruct(exp);
	cond = findImagePaths(exp,cond);
		
elseif strcmp(runMode,'full')
	SITEN = 9;
	inputData
	cond = createConditionStruct(exp);
	cond = findImagePaths(exp,cond);
end

conditionN = length(cond);

disp('Completed importing data')

%% SEGMENTATION

close all

for j=1:conditionN
 	for i=1:cond(j).localImageN

		cond(j).imageLocal(i) = imgSegmentWatershed(cond(j).imageLocal(i));

	end
end

store = cond;

disp('Completed image segmentation')

%% FILTERING

cond = store;

for j=1:conditionN
	for i=1:cond(j).localImageN
		
		cond(j).imageLocal(i).cellN = cond(j).imageLocal(i).cellN(1);
		
		cond(j).imageLocal(i) = imgFilterEdges(cond(j).imageLocal(i));
		
 		cond(j).imageLocal(i) = imgFindBackground(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFilterUnmasked(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFilterCellDimensions(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFilterRedGrad(cond(j).imageLocal(i));
		
	end
end

disp('Completed cell filtering')

%% DISTANCE MAP

for j=1:conditionN
	for i=1:cond(j).localImageN
		
		cond(j).imageLocal(i) = distanceMap(cond(j).imageLocal(i));

	end
end

disp('Completed localisation distance map')

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

%%

disp('Full analysis completed')


