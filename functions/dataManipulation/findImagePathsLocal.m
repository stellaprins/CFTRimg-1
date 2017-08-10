function [ redPathArray,yelPathArray ] = findImagePathsLocal( ...
	currentCondition,experimentStruct,redPathArray,yelPathArray)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

global SITEN

cmpCondition = strcmp(experimentStruct.conditionStr,currentCondition);
conditionLocation = sum(cmpCondition ...
	.* (1:length(experimentStruct.conditionStr)));

if sum(cmpCondition) == 1

	fileFolder = fullfile(experimentStruct.baseFolder...
		,experimentStruct.expStr...
		,'TimePoint_1');

	wells = {experimentStruct.condWells{conditionLocation,:}};

	tmpRedPathArray = cell(length(wells)*SITEN,1);
	tmpYelPathArray = cell(length(wells)*SITEN,1);

	for i=1:length(wells)

		% red
		filename = strcat(experimentStruct.filePrefix,wells{i},'_s*_w2.TIF');
		redDirOutput = dir(fullfile(fileFolder,filename));

		% yellow
		filename = strcat(experimentStruct.filePrefix,wells{i},'_s*_w1.TIF');
		yelDirOutput = dir(fullfile(fileFolder,filename));

		for p = 1:SITEN
			tmpRedPathArray{(i-1)*SITEN + p} = ...
				fullfile(fileFolder,redDirOutput(p).name);
			tmpYelPathArray{(i-1)*SITEN + p} = ...
				fullfile(fileFolder,yelDirOutput(p).name);
		end

	end
	
	redPathArray = [redPathArray; tmpRedPathArray];
	yelPathArray = [yelPathArray; tmpYelPathArray];

end

end