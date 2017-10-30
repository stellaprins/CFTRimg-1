function [ plateStructArray ] = findImagePaths( ...
	experimentStructArray,plateStructArray)
%FINDIMAGEPATHS construct image paths from inputted data
%   Cycles through all plates. For each plate, the appropriate experiments
%   are selected. The path names are then constructed in
%   'findImagePathsLocal' and 'findImagePathsQuench'. Using these arrays of
%   path names, a struct is created for each image (or well for quenching
%   experiments).

plateN = length(plateStructArray);
experimentN = length(experimentStructArray);

plateStr = unique(horzcat(experimentStructArray.plateStr));

for j=1:plateN
	
	currentPlate = plateStr{j};
	
	mutationArray = cell(0);
	test_controlArray = cell(0);
	
	redPathArrayLocal = cell(0);
	yelPathArrayLocal = cell(0);
	
	redPathArrayQuench = cell(0,2);
	yelPathArrayQuench = cell(0,70);
	
	for i=1:experimentN
		
		expStruct = experimentStructArray(i);
		
		cmpPlate = strcmp(expStruct.plateStr,currentPlate);
		
		if sum(cmpPlate == 1)
		
			switch expStruct.local_quench

				case 'local'

					[mutationArray,redPathArrayLocal,yelPathArrayLocal] = ...
					findImagePathsLocal(expStruct,mutationArray...
					,redPathArrayLocal,yelPathArrayLocal);

				case 'quench'

					[mutationArray,test_controlArray,...
						redPathArrayQuench,yelPathArrayQuench] = ...
					findImagePathsQuench(expStruct,mutationArray,test_controlArray...
					,redPathArrayQuench,yelPathArrayQuench);

				otherwise
					fprintf(strcat('In experimentStruct %d, exp(%d).local_quench',...
						' must be either "local" or "quench"\n'),i,i)
			end
		
		end
		
	end
	
	plateStructArray(j).imageLocal = createImageLocalStruct(mutationArray...
		,redPathArrayLocal,yelPathArrayLocal);
	
	plateStructArray(j).imageQuench = ...
		createImageQuenchStruct(mutationArray,test_controlArray...
		,redPathArrayQuench,yelPathArrayQuench);
	
end

end