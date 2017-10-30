function [ redPathArray,yelPathArray ] = findImagePathsLocal( ...
	conditionLocation,experimentStruct,redPathArray,yelPathArray)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

global SITEN

fileFolder = fullfile(experimentStruct.baseFolder...
	,experimentStruct.expStr...
	,'TimePoint_1');

wells = {experimentStruct.condWells{conditionLocation,:}};
wellN = sum(~cellfun(@isempty,experimentStruct.condWells(conditionLocation,:)));

tmpRedPathArray = cell(wellN*SITEN,1);
tmpYelPathArray = cell(wellN*SITEN,1);

for i=1:wellN

	% red
	filename = strcat(experimentStruct.filePrefix,wells{i},'_s*_w2.TIF');
	redDirOutput = dir(fullfile(fileFolder,filename));
	if isempty(redDirOutput)
		fprintf('Check experiment "%s".\nFor well %s a file cannot be found.\n',...
		experimentStruct.expStr,wells{i})
	end
	
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
