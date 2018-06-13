function [ expStructArray ] = findImagePaths( ...
	plateStructArray,expStructArray)
%FIND_IMAGE_PATHS construct image paths from inputted data
%   Cycles through all experiments. For each experiment, the appropriate
%   plates are selected. The path names are then constructed in
%   'findImagePathsLocal' and 'findImagePathsQuench'. Using these arrays of
%   path names, a struct is created for each image (or well for quenching
%   experiments).

plateN	= length(plateStructArray);
expN		= length(expStructArray);

expStr	= unique(horzcat(plateStructArray.experimentStr));

for j=1:expN
	
	currentExp					= expStr{j};
	conditionArray			= cell(0);
	plateStrArray				= cell(0);
	test_controlArray		= cell(0);
	redPathArrayLocal		= cell(0);
	yelPathArrayLocal		= cell(0);
	redPathArrayQuench	= cell(0,2);
	yelPathArrayQuench	= cell(0,70);
	
	for i=1:plateN
		plateStruct = plateStructArray(i);
		compareExp = strcmp(plateStruct.experimentStr,currentExp);
		
		currentPlateStr = plateStruct.plateStr;
		beforeArrayLength = length(conditionArray);
		
		if sum(compareExp == 1)
		
			switch plateStruct.local_quench

				case 'local'

					[conditionArray,redPathArrayLocal,yelPathArrayLocal] = ...
					findImagePathsLocal(plateStruct,conditionArray,...
					redPathArrayLocal,yelPathArrayLocal);

				case 'quench'

					[conditionArray,...
						test_controlArray,redPathArrayQuench,yelPathArrayQuench] = ...
					findImagePathsQuench(plateStruct,conditionArray,...
					test_controlArray,redPathArrayQuench,yelPathArrayQuench);

				otherwise
					fprintf(strcat('In plateStruct %d, exp(%d).local_quench',...
						' must be either "local" or "quench"\n'),i,i)
			end
		
		end
		
		afterArrayLength = length(conditionArray);
		if afterArrayLength - beforeArrayLength > 0
			plateStrArray(beforeArrayLength+1:afterArrayLength) = currentPlateStr;
		end
		
	end
	
	expStructArray(j).imageLocal = ...
		createImageLocalStruct(conditionArray, plateStrArray,...
		redPathArrayLocal,yelPathArrayLocal);
	
	expStructArray(j).imageQuench = ...
		createImageQuenchStruct(conditionArray, plateStrArray,...
		test_controlArray,redPathArrayQuench,yelPathArrayQuench);
	
end


end