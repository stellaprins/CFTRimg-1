function [ conditionStructArray ] = findImagePaths( ...
	experimentStructArray,conditionStructArray)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

conditionN = length(conditionStructArray);
experimentN = length(experimentStructArray);

conditionStr = unique(horzcat(experimentStructArray.conditionStr));

for j=1:conditionN
	
	currentCondition = conditionStr{j};
	
	redPathArrayLocal = cell(0);
	yelPathArrayLocal = cell(0);

	redPathArrayTest = cell(0,2);
	yelPathArrayTest = cell(0,70);
	
	redPathArrayControl = cell(0,2);
	yelPathArrayControl = cell(0,70);
	
	for i=1:experimentN
		
		expStruct = experimentStructArray(i);
		
		cmpCondition = strcmp(expStruct.conditionStr,currentCondition);
		conditionLoc = sum(cmpCondition .* (1:length(expStruct.conditionStr)));
		
		if sum(cmpCondition == 1)
		
			switch expStruct.local_quench

				case 'local'

					[redPathArrayLocal,yelPathArrayLocal] = ...
					findImagePathsLocal(conditionLoc,expStruct...
					,redPathArrayLocal,yelPathArrayLocal);

				case 'quench'

					[redPathArrayTest,yelPathArrayTest,...
					redPathArrayControl,yelPathArrayControl] = ...
					findImagePathsQuench(conditionLoc,expStruct...
					,redPathArrayTest,yelPathArrayTest...
					,redPathArrayControl,yelPathArrayControl);

				otherwise
					fprintf(strcat('In experimentStruct %d, exp(%d).local_quench',...
						' must be either "local" or "quench"\n'),i,i)
			end
		
		end
		
	end
	
	conditionStructArray(j).imageLocal = createImageLocalStruct(...
		redPathArrayLocal,yelPathArrayLocal);
	conditionStructArray(j).localImageN = length(redPathArrayLocal);
	
	testN = size(redPathArrayTest,1);
	controlN = size(redPathArrayControl,1);
	conditionStructArray(j).quenchImageTestN = testN;
	conditionStructArray(j).quenchImageControlN = controlN;
	
	conditionStructArray(j).imageQuench = ...
		createImageQuenchStruct(redPathArrayTest,yelPathArrayTest...
		,redPathArrayControl,yelPathArrayControl);
	
end

end