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

% find the largest number of quench time points across all plates, to
% initialize arrays
maxQuenchTimePointN = 0;
for i=1:plateN
	plateStruct = plateStructArray(i);
	maxQuenchTimePointN = max(maxQuenchTimePointN,plateStruct.quenchTimeline(end));
end

expStr	= unique(horzcat(plateStructArray.experimentStr));
for j=1:expN
	
	currentExp					= expStr{j};
	normConditionArray	= cell(0);
	conditionArray			= cell(0);
	plateStrArray				= cell(0);
	
	binningArray				= zeros(0);
	redPathArrayLocal		= cell(0);
	yelPathArrayLocal		= cell(0);
	
	test_controlArray		= cell(0);
	timelineArray				= zeros(0,3);
	timeStepArray				= zeros(0);
	redPathArrayQuench	= cell(0,2);
	yelPathArrayQuench	= cell(0,maxQuenchTimePointN);
	
	for i=1:plateN
		plateStruct = plateStructArray(i);
		compareExp = strcmp(plateStruct.experimentStr,currentExp);
		
		currentNormCond		= plateStruct.normConditionStr;
		currentPlateStr		= plateStruct.plateStr;
		currentBinning		= plateStruct.localBinning;
		currentTimeline		= plateStruct.quenchTimeline;
		currentTimeStep		= plateStruct.quenchTimeStep;
		
		beforeArrayLength				= length(conditionArray);
		beforeArrayLengthLocal	= size(redPathArrayLocal,1);
		beforeArrayLengthQuench	= size(redPathArrayQuench,1);
		
		if sum(compareExp == 1)
		
			switch plateStruct.local_quench

				case 'local'

					[conditionArray,redPathArrayLocal,yelPathArrayLocal] = ...
					findImagePathsLocal(plateStruct,conditionArray...
					,redPathArrayLocal,yelPathArrayLocal);

				case 'quench'

					[conditionArray,test_controlArray...
						,redPathArrayQuench,yelPathArrayQuench] = ...
					findImagePathsQuench(plateStruct,conditionArray,...
					test_controlArray,redPathArrayQuench,yelPathArrayQuench);

				otherwise
					fprintf(strcat('In plateStruct %d, exp(%d).local_quench',...
						' must be either "local" or "quench"\n'),i,i)
			end
			
			normConditionArray = unique(horzcat(normConditionArray,currentNormCond));
		
		end
		
		afterArrayLength				= length(conditionArray);
		afterArrayLengthLocal		= size(redPathArrayLocal,1);
		afterArrayLengthQuench	= size(redPathArrayQuench,1);
		if afterArrayLength - beforeArrayLength > 0
			plateStrArray(beforeArrayLength+1:afterArrayLength) ...
				= currentPlateStr;
		end
		if afterArrayLengthLocal - beforeArrayLengthLocal > 0
			binningArray(beforeArrayLengthLocal+1:afterArrayLengthLocal) = ...
				currentBinning;
		end
		if afterArrayLengthQuench - beforeArrayLengthQuench > 0
			for idx=beforeArrayLengthQuench+1:afterArrayLengthQuench
				timelineArray(idx,:) = currentTimeline;
			end
			timeStepArray(beforeArrayLengthQuench+1:afterArrayLengthQuench) = ...
				currentTimeStep;
		end
		
	end
	
	expStructArray(j).imageLocal = ...
		createImageLocalStruct(conditionArray,plateStrArray,binningArray...
		,redPathArrayLocal,yelPathArrayLocal);
	
	expStructArray(j).imageQuench = ...
		createImageQuenchStruct(conditionArray, plateStrArray,...
		test_controlArray,timelineArray,timeStepArray...
		,redPathArrayQuench,yelPathArrayQuench);
	
	expStructArray(j).normConditionStr = normConditionArray;
	
end


end