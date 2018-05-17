function [ tmpRedPathArray,tmpYelPathArray ] = ...
	constructPathNameQuench( experimentStruct,wells,wellIdx,redTimePoints...
	,tmpRedPathArray,tmpYelPathArray )
%CONSTRUCT_PATH_NAME_QUENCH final process of making quenching path name
%   Combine all sections of quenching path name strings

% red
		for i=1:2
			fileFolder = fullfile(experimentStruct.baseFolder...
			,experimentStruct.expStr...
			,['TimePoint_',redTimePoints{i}]);
			filename = strcat(experimentStruct.filePrefix,wells{wellIdx},'_w2.TIF');			
			tmpRedPathArray{wellIdx,i} = fullfile(fileFolder,filename);
		end

		% yellow
		for i=1:70
			fileFolder = fullfile(experimentStruct.baseFolder...
			,experimentStruct.expStr...
			,['TimePoint_',char(string(i))]);
			filename = strcat(experimentStruct.filePrefix,wells{wellIdx},'_w1.TIF');
			tmpYelPathArray{wellIdx,i} = fullfile(fileFolder,filename);
		end

end

