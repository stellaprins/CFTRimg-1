function [ conditionArray,redPathArray,yelPathArray ] = ...
	findImagePathsLocal(plateStruct,conditionArray,redPathArray,yelPathArray)
%FIND_IMAGE_PATHS_LOCAL construct path names for localization images
%   Add to 'redPathArray' and 'yelPathArray' new path names constructed for
%   each localization image. Done for all wells in an experiment.

fileFolder = fullfile(plateStruct.baseFolder...
	,plateStruct.folderName...
	,'TimePoint_1');

wells = {plateStruct.condWells{:}};
emptyCells = cellfun('isempty',wells);
wells(emptyCells) = [];
wellN = length(wells);
siteN = plateStruct.localSiteN;

tmpConditionArray	= cell(wellN*siteN,1);
tmpRedPathArray		= cell(wellN*siteN,1);
tmpYelPathArray		= cell(wellN*siteN,1);

for j=1:wellN

	% red
	filename			= strcat(plateStruct.filePrefix,wells{j},'_s*_w2.TIF');
	redDirOutput	= dir(fullfile(fileFolder,filename));
		if isempty(redDirOutput)
			fprintf('Check experiment "%s".\nFor well %s a file cannot be found.\n',...
			plateStruct.folderName,wells{j})
		end

	% yellow
	filename			= strcat(plateStruct.filePrefix,wells{j},'_s*_w1.TIF');
	yelDirOutput	= dir(fullfile(fileFolder,filename));
	
	% find current condition for this well
	locationMatrix = strcmp(wells{j},plateStruct.condWells);
	for i=1:size(plateStruct.condWells,1)
		if sum(locationMatrix(i,:)) == 1
			currentCondition = plateStruct.conditionStr{i};
		end
	end

% 	
	for p = 1:siteN
		tmpConditionArray{(j-1)*siteN + p} = ...
			currentCondition;
		tmpRedPathArray{(j-1)*siteN + p} = ...
			fullfile(fileFolder,redDirOutput(p).name);
		tmpYelPathArray{(j-1)*siteN + p} = ...
			fullfile(fileFolder,yelDirOutput(p).name);
		
	end

end

conditionArray	= [conditionArray; tmpConditionArray];
redPathArray		= [redPathArray; tmpRedPathArray];
yelPathArray		= [yelPathArray; tmpYelPathArray];

end
