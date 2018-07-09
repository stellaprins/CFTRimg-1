function [ conditionArray,binningArray,redPathArray,yelPathArray ] = ...
	findImagePaths_local(inputStruct,conditionArray,binningArray,...
	redPathArray,yelPathArray)
%FIND_IMAGE_PATHS_LOCAL construct path names for localization images
%   Add to 'redPathArray' and 'yelPathArray' new path names constructed for
%   each localization image. Done for all wells in an experiment.

fileFolder = fullfile(inputStruct.baseFolder...
	,inputStruct.folderName...
	,'TimePoint_1');

wells = {inputStruct.condWells{:}};
emptyCells = cellfun('isempty',wells);
wells(emptyCells) = [];
wellN = length(wells);
siteN = inputStruct.siteN;

tmpConditionArray	= cell(wellN*siteN,1);
tmpBinningArray		= cell(wellN*siteN,1);
tmpRedPathArray		= cell(wellN*siteN,1);
tmpYelPathArray		= cell(wellN*siteN,1);

for j=1:wellN

	% red
	filename			= strcat(inputStruct.filePrefix,wells{j},'_s*_w2.TIF');
	redDirOutput	= dir(fullfile(fileFolder,filename));
		if isempty(redDirOutput)
			fprintf('Check experiment "%s".\nFor well %s a file cannot be found.\n',...
			inputStruct.folderName,wells{j})
		end

	% yellow
	filename			= strcat(inputStruct.filePrefix,wells{j},'_s*_w1.TIF');
	yelDirOutput	= dir(fullfile(fileFolder,filename));
	
	% find current condition for this well
	locationMatrix = strcmp(wells{j},inputStruct.condWells);
	for i=1:size(inputStruct.condWells,1)
		if sum(locationMatrix(i,:)) == 1
			currentCondition	= inputStruct.conditionStr{i};
			currentBinning		= inputStruct.pixelBinning;
		end
	end

% 	
	for p = 1:siteN
		tmpConditionArray{(j-1)*siteN + p} = ...
			currentCondition;
		tmpBinningArray{(j-1)*siteN + p} = ...
			currentBinning;
		tmpRedPathArray{(j-1)*siteN + p} = ...
			fullfile(fileFolder,redDirOutput(p).name);
		tmpYelPathArray{(j-1)*siteN + p} = ...
			fullfile(fileFolder,yelDirOutput(p).name);
		
	end

end

conditionArray	= [conditionArray; tmpConditionArray];
binningArray		= [binningArray; tmpBinningArray];
redPathArray		= [redPathArray; tmpRedPathArray];
yelPathArray		= [yelPathArray; tmpYelPathArray];

end
