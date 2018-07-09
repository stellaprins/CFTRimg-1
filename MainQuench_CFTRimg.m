
clc
clear
close all

addpath(genpath('functions'))

addpath(genpath(fullfile('example','input'))) % location of your input folder
example_quench % the name of your input file

%% STRUCTURING DATA
tic
plate		= createPlateStruct_quench(input);		% creates an empty struct for each plate
plate		= populatePlate_quench(input,plate);	% collects the path names for each image
plateN	= length(plate);											% and creates a struct for each image

disp('Completed setting up data structures')
time(1) = toc;

%% QUENCHING ANALYSIS
for j=1:plateN
	quenchImageN = size(plate(j).well,1);
	for i=1:quenchImageN
 		plate(j).well(i) = findRedMaskChange(plate(j).well(i));
		plate(j).well(i) = findYelInsideOverTime(plate(j).well(i));
		plate(j).well(i) = calculateConcIodine(plate(j).well(i));
	end
end
disp		('Completed quenching analysis')
time(2) = toc;

%% CREATE RESULTS STRUCTS

		resultsQuench = createResultsQuenchStruct(plate);
		resultsQuench = populateResultsQuench(resultsQuench,plate);

time(3) = toc;
disp('Full analysis completed')
save(saveWorkspaceHere)
