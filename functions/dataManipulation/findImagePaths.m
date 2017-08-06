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

	redPathArrayQuench = cell(0,2);
	yelPathArrayQuench = cell(0,70);
	
	for i=1:experimentN
		
		expStruct = experimentStructArray(i);
		
		if strcmp(expStruct.local_quench,'local')
			
			[redPathArrayLocal,yelPathArrayLocal] = findImagePathsLocal(...
				currentCond,expStruct,redPathArrayLocal,yelPathArrayLocal);
		
		elseif strcmp(expStruct.local_quench,'quench')
			
			[redPathArrayQuench,yelPathArrayQuench] = findImagePathsQuench(...
				currentCond,expStruct,redPathArrayQuench,yelPathArrayQuench);
		
		else
			disp(fprintf('In experimentStruct %d, exp(%d).local_quench must be either "local" or "quench"\n',i,i))
		end
		
	end
	
	conditionStructArray(j).imageLocal = createImageLocalStruct(...
		redPathArrayLocal,yelPathArrayLocal);
	conditionStructArray(j).imageQuench = createImageQuenchStruct(...
		redPathArrayQuench,yelPathArrayQuench);
	conditionStructArray(j).localImageN = length(redPathArrayLocal);
	conditionStructArray(j).quenchImageN = size(redPathArrayQuench,1);
	
end

end