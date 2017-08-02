function [ conditionStruct ] = findImagePathsPerCondition( ...
	conditionStruct,experimentStruct,baseFolder,local_or_quench )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

global SITEN

conditionN = length(conditionStruct);
experimentN = length(experimentStruct);

conditionStr = unique(horzcat(experimentStruct.conditionStr));

for i=1:conditionN
	
	condition = conditionStr{i};
	
	redPathArray = cell(0);
	yelPathArray = cell(0);
	
	for j=1:experimentN
		
		experimentStr = experimentStruct(j).expStr;
		
		cmpLocalQuench=sum(strcmp(experimentStruct(j).local_quench,local_or_quench));
		cmpCondition = strcmp(experimentStruct(j).conditionStr,condition);
		conditionLocation = sum(cmpCondition ...
			.* (1:length(experimentStruct(j).conditionStr)));
		
		if cmpLocalQuench == 1 && sum(cmpCondition) == 1
			
			fileFolder = fullfile(baseFolder,experimentStr,local_or_quench);
			filePrefix = strcat(experimentStr,'_',local_or_quench,'_');
			
			wells = {experimentStruct(j).condWells{conditionLocation,:}};
			
			tmpRedPathArray = cell(length(wells)*SITEN,1);
			tmpYelPathArray = cell(length(wells)*SITEN,1);
			
			for k=1:length(wells)

				% red
				filename = strcat(filePrefix,wells{k},'_s*_w2.TIF');
				redDirOutput = dir(fullfile(fileFolder,filename));

				% yellow
				filename = strcat(filePrefix,wells{k},'_s*_w1.TIF');
				yelDirOutput = dir(fullfile(fileFolder,filename));

				for p = 1:SITEN
					tmpRedPathArray{(k-1)*SITEN + p} = ...
						fullfile(fileFolder,redDirOutput(p).name);
					tmpYelPathArray{(k-1)*SITEN + p} = ...
						fullfile(fileFolder,yelDirOutput(p).name);
				end
				
			end
			
		end
		
		redPathArray = [redPathArray; tmpRedPathArray];
		yelPathArray = [yelPathArray; tmpYelPathArray];
		
	end
	
	conditionStruct(i).imageLocal = createImageLocalStruct(redPathArray,yelPathArray);
	conditionStruct(i).imageN = length(redPathArray);
	
end

end