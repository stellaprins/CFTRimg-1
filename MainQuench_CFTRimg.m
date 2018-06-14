clc
clear
close all

addpath(genpath('functions'))

addpath(genpath(fullfile('example','input'))) %% include the location of your input folder
example_quench % the name of your input file

%% STRUCTURING DATA
tic
exp		= createExpStruct(plate);			% creates an empty struct for each plate
exp		= findImagePaths(plate,exp);	% collects the path names for each image
expN	= length(exp);							% and creates a struct for each image
disp('Completed setting up data structures')
time(1) = toc;

%% QUENCHING ANALYSIS
for j=1:expN
	quenchImageN = size(exp(j).imageQuench,1);
	for i=1:quenchImageN
 		exp(j).imageQuench(i) = findRedMaskChange(exp(j).imageQuench(i));
		exp(j).imageQuench(i) = findYelInsideOverTime(exp(j).imageQuench(i));
		exp(j).imageQuench(i) = calculateConcIodine(exp(j).imageQuench(i));
	end
end
disp		('Completed quenching analysis')
time(2) = toc;

%% CREATE RESULTS STRUCTS

		resultsQuench = createResultsQuenchStruct(exp);
		resultsQuench = populateResultsQuench(resultsQuench,exp);

time(3) = toc;
disp('Full analysis completed')
save(saveWorkspaceHere)
