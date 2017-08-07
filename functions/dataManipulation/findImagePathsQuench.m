function [ redPathArrayTest,yelPathArrayTest...
	,redPathArrayControl,yelPathArrayControl] = findImagePathsQuench( ...
	currentCondition,experimentStruct...
	,redPathArrayTest,yelPathArrayTest...
	,redPathArrayControl,yelPathArrayControl)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

cmpCondition = strcmp(experimentStruct.conditionStr,currentCondition);
conditionLocation = sum(cmpCondition ...
	.* (1:length(experimentStruct.conditionStr)));

redTimePoints = {'1','70'};

if sum(cmpCondition) == 1

	wellsTest = {experimentStruct.condWells{conditionLocation,:}};
	wellsControl = {experimentStruct.condWellsControl{conditionLocation,:}};

	tmpRedPathArrayTest = cell(length(wellsTest),2);
	tmpYelPathArrayTest = cell(length(wellsTest),70);
	tmpRedPathArrayControl = cell(length(wellsControl),2);
	tmpYelPathArrayControl = cell(length(wellsControl),70);

	for j=1:length(wellsTest)
		
		[tmpRedPathArrayTest,tmpYelPathArrayTest] = ...
			constructPathName(experimentStruct,wellsTest,j,redTimePoints...
			,tmpRedPathArrayTest,tmpYelPathArrayTest);
		
	end
	
	for j=1:length(wellsControl)
		
		[tmpRedPathArrayControl,tmpYelPathArrayControl] = ...
			constructPathName(experimentStruct,wellsControl,j,redTimePoints...
			,tmpRedPathArrayControl,tmpYelPathArrayControl);
		
	end
	
	redPathArrayTest = [redPathArrayTest; tmpRedPathArrayTest];
	yelPathArrayTest = [yelPathArrayTest; tmpYelPathArrayTest];
	
	redPathArrayControl = [redPathArrayControl; tmpRedPathArrayControl];
	yelPathArrayControl = [yelPathArrayControl; tmpYelPathArrayControl];

end

end
