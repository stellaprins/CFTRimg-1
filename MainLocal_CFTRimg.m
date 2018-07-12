
clc
clear
close all

addpath(genpath('functions'))

addpath(genpath(fullfile('example','input'))) % location of your input folder
example_local																	% the name of your input file

%% STRUCTURING DATA
tic
plate		= createPlateStruct_local(input);			% creates an empty struct for each plate,
plate		= populatePlate_local(input,plate);		% moves appropriate data into plate struct
plateN	= length(plate);											% and creates a struct for each image

disp('Completed setting up data structures')
time(1) = toc;

%% SEGMENTATION
close all
for j = 1:plateN
	imageN = length(plate(j).image);
	for i = 1:imageN
		plate(j).image(i) = imgSegmentWatershed(plate(j).image(i));
	end
end
storeSegmented = plate;
disp		('Completed image segmentation')
time(2)	= toc;

%% FILTERING
plate = storeSegmented;
for j = 1:plateN
	imageN = length(plate(j).image);
	for i = 1:imageN
		plate(j).image(i).cellN = plate(j).image(i).cellN(1);
 		plate(j).image(i) = imgFilterEdges(plate(j).image(i));
 		plate(j).image(i) = imgFilterUnmasked(plate(j).image(i));
		plate(j).image(i) = imgFilterCellDimensions(plate(j).image(i));
	end
end
storeFiltered = plate;
disp		('Completed cell filtering')
time(3) = toc;

%% DISTANCE MAP
plate = storeFiltered;
	for j = 1:plateN
		imageN = length(plate(j).image);
		for i = 1:imageN
			plate(j).image(i) = imgFindBackground(plate(j).image(i));
			plate(j).image(i) = distanceMap(plate(j).image(i));
		end
	end
disp		('Completed localization distance maps')
time(4) = toc;

%% CREATE RESULTS STRUCTS
for j=1:plateN
	imageN = length(plate(j).image);
	for i=1:imageN
		plate(j).image(i) = filterNegativeMetric(plate(j).image(i));
	end
	plate(j) = logCellLocation(plate(j),j);
end

% move key values into temporary a structure for normalizing
normPlate = createNormalizeStruct(plate);
normPlate = normalizeResultsWT(normPlate);

% move normalized results into a structure ready to output results
resultsLocal = createResultsLocalStruct(normPlate);
resultsLocal = populateResultsLocal(resultsLocal,normPlate);
		
time(5)				= toc;

disp					('Full analysis completed')
save					(saveWorkspaceHere)
