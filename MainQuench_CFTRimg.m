clc
clear
addpath(genpath('functions'))
addpath(genpath('input'))
%%
VX809_quench_% the name of your input file
saveWorkspaceHere = './VX809_quench_220118';

%%
close all
imtool close all

%% STRUCTURING DATA
tic
plate		= createPlateStruct(exp);			% creates an empty struct for each plate
plate		= findImagePaths(exp,plate);	% collects the path names for each image
plateN	= length(plate);							% and creates a struct for each image
disp('Completed setting up data structures')
time(1) = toc;

%% QUENCHING ANALYSIS
for j=1:plateN
	quenchImageN = size(plate(j).imageQuench,1);
	for i=1:quenchImageN
		plate(j).imageQuench(i) = findRedMaskChange(plate(j).imageQuench(i));
		plate(j).imageQuench(i) = findYelInsideOverTime(plate(j).imageQuench(i));
		plate(j).imageQuench(i) = calculateConcIodine(plate(j).imageQuench(i));
	end
end
disp		('Completed quenching analysis')
time(5) = toc;

%% CREATE RESULTS STRUCTS

		resultsQuench = createResultsQuenchStruct(plate);
		resultsQuench = populateResultsQuench(resultsQuench,plate);

time(6)				= toc;
disp					('Full analysis completed')
save					(saveWorkspaceHere)
