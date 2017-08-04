function [ redPathArray,yelPathArray ] = findImagePathsQuench( ...
	currentCondition,experimentStruct,redPathArray,yelPathArray)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

cmpCondition = strcmp(experimentStruct.conditionStr,currentCondition);
conditionLocation = sum(cmpCondition ...
	.* (1:length(experimentStruct.conditionStr)));

redTimePoints = {'1','70'};

if sum(cmpCondition) == 1

	wells = {experimentStruct.condWells{conditionLocation,:}};

	tmpRedPathArray = cell(length(wells),2);
	tmpYelPathArray = cell(length(wells),70);

	for j=1:length(wells)
		
		% red
		for i=1:2
			fileFolder = fullfile(experimentStruct.baseFolder...
			,experimentStruct.expStr...
			,['TimePoint_',redTimePoints{i}]);
			filename = strcat(experimentStruct.filePrefix,wells{j},'_w2.TIF');			
			tmpRedPathArray{j,i} = fullfile(fileFolder,filename);
		end

		% yellow
		for i=1:70
			fileFolder = fullfile(experimentStruct.baseFolder...
			,experimentStruct.expStr...
			,['TimePoint_',char(string(i))]);
			filename = strcat(experimentStruct.filePrefix,wells{j},'_w1.TIF');
			tmpYelPathArray{j,i} = fullfile(fileFolder,filename);
		end
		
	end
	
	redPathArray = [redPathArray; tmpRedPathArray];
	yelPathArray = [yelPathArray; tmpYelPathArray];

end

end
