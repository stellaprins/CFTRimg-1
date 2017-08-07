function [ conditionStructArray ] = findImagePaths( ...
	experimentStructArray,conditionStructArray)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

conditionN = length(conditionStructArray);
experimentN = length(experimentStructArray);

conditionStr = unique(horzcat(experimentStructArray.conditionStr));

for j=1:conditionN
	
	currentCond = conditionStr{j};
	
	redPathArrayLocal = cell(0);
	yelPathArrayLocal = cell(0);

	redPathArrayTest = cell(0,2);
	yelPathArrayTest = cell(0,70);
	
	redPathArrayControl = cell(0,2);
	yelPathArrayControl = cell(0,70);
	
	for i=1:experimentN
		
		expStruct = experimentStructArray(i);
		
		if strcmp(expStruct.local_quench,'local')
			
			[redPathArrayLocal,yelPathArrayLocal] = findImagePathsLocal(...
				currentCond,expStruct,redPathArrayLocal,yelPathArrayLocal);
		
		elseif strcmp(expStruct.local_quench,'quench')
			
			[redPathArrayTest,yelPathArrayTest,...
				redPathArrayControl,yelPathArrayControl] = ...
				findImagePathsQuench(currentCond,expStruct...
				,redPathArrayTest,yelPathArrayTest...
				,redPathArrayControl,yelPathArrayControl);
		
		else
			disp(fprintf('In experimentStruct %d, exp(%d).local_quench must be either "local" or "quench"\n',i,i))
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