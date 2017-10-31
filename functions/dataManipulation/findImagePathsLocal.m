function [ mutationArray,redPathArray,yelPathArray ] = findImagePathsLocal...
	(experimentStruct,mutationArray,redPathArray,yelPathArray)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

global SITEN

fileFolder = fullfile(experimentStruct.baseFolder...
	,experimentStruct.expStr...
	,'TimePoint_1');

wells = {experimentStruct.condWells{:}};
emptyCells = cellfun('isempty',wells);
wells(emptyCells) = [];
wellN = length(wells);

tmpMutationArray	= cell(wellN*SITEN,1);
tmpRedPathArray		= cell(wellN*SITEN,1);
tmpYelPathArray		= cell(wellN*SITEN,1);

for j=1:wellN

	% red
	filename = strcat(experimentStruct.filePrefix,wells{j},'_s*_w2.TIF');
	redDirOutput = dir(fullfile(fileFolder,filename));
	if isempty(redDirOutput)
		fprintf('Check experiment "%s".\nFor well %s a file cannot be found.\n',...
		experimentStruct.expStr,wells{j})
	end
	
	% yellow
	filename = strcat(experimentStruct.filePrefix,wells{j},'_s*_w1.TIF');
	yelDirOutput = dir(fullfile(fileFolder,filename));
	
	% find current mutation for this well
	locationMatrix = strcmp(wells{j},experimentStruct.condWells);
	for i=1:size(experimentStruct.condWells,1)
		if sum(locationMatrix(i,:)) == 1
			currentMutation = experimentStruct.conditionStr{i};
		end
	end
	
	for p = 1:SITEN
		tmpMutationArray{(j-1)*SITEN + p} = ...
			currentMutation;
		tmpRedPathArray{(j-1)*SITEN + p} = ...
			fullfile(fileFolder,redDirOutput(p).name);
		tmpYelPathArray{(j-1)*SITEN + p} = ...
			fullfile(fileFolder,yelDirOutput(p).name);
		
	end

end

mutationArray = [mutationArray; tmpMutationArray];

redPathArray = [redPathArray; tmpRedPathArray];
yelPathArray = [yelPathArray; tmpYelPathArray];

end
