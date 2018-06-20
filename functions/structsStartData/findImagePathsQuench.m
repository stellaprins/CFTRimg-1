function [ conditionArray,test_controlArray,redPathArray,yelPathArray] = ...
	findImagePathsQuench(plateStruct,conditionArray,test_controlArray ...
	,redPathArray,yelPathArray)
%FIND_IMAGE_PATHS_QUENCH construct path names for quenching images
%   Add to 'redPathArray' and 'yelPathArray' new path names constructed for
%   each quenching image, whether of test condition or control. Cycles
%   through all wells in an experiment. More complicated than for
%   localization images, and requires an additional function to construct
%   path name.

maxTimePointN = size(yelPathArray,2);

timePointN = plateStruct.quenchTimeline(end);
strTimePointN = num2str(timePointN);

redTimePoints = {num2str(1),strTimePointN};

wellsTest = {plateStruct.condWells{:}};
emptyCellsTest = cellfun('isempty',wellsTest);
wellsTest(emptyCellsTest) = [];
wellsTestN = length(wellsTest);

wellsControl = {plateStruct.condWellsControl{:}};
emptyCellsControl = cellfun('isempty',wellsControl);
wellsControl(emptyCellsControl) = [];
wellsControlN = length(wellsControl);

tmpTestArray						= cell(wellsTestN,1);
tmpControlArray					= cell(wellsControlN,1);
tmpRedPathArrayTest			= cell(wellsTestN,2);
tmpYelPathArrayTest			= cell(wellsTestN,maxTimePointN);
tmpRedPathArrayControl	= cell(wellsControlN,2);
tmpYelPathArrayControl	= cell(wellsControlN,maxTimePointN);

tmpConditionArray				= cell(wellsTestN,1);

for j=1:wellsTestN

	% construct the path names for the test condition wells
	[tmpRedPathArrayTest,tmpYelPathArrayTest] = ...
		constructPathNameQuench(plateStruct,wellsTest,j,redTimePoints...
		,tmpRedPathArrayTest,tmpYelPathArrayTest);
	
	% create constant array of 'test' labels
	tmpTestArray{j} = 'test';
	
	% find current mutation for this well
	locationMatrix = strcmp(wellsTest{j},plateStruct.condWells);
	for i=1:size(plateStruct.condWells,1)
		if sum(locationMatrix(i,:)) == 1
			tmpConditionArray{j} = plateStruct.conditionStr{i};
		end
	end

end

conditionArray = [conditionArray; tmpConditionArray];

tmpConditionArray				= cell(wellsControlN,1);

for j=1:wellsControlN
 
	% construct the path names for the control condition wells
	[tmpRedPathArrayControl,tmpYelPathArrayControl] = ...
		constructPathNameQuench(plateStruct,wellsControl,j,redTimePoints...
		,tmpRedPathArrayControl,tmpYelPathArrayControl);
	
	% create constant array of 'control' labels
	tmpControlArray{j} = 'control';
	
	% find current mutation for this well
	locationMatrix = strcmp(wellsControl{j},plateStruct.condWellsControl);
	for i=1:size(plateStruct.condWellsControl,1)
		if sum(locationMatrix(i,:)) == 1
			tmpConditionArray{j} = plateStruct.conditionStr{i};
		end
	end

end

conditionArray = [conditionArray; tmpConditionArray];
test_controlArray = [test_controlArray; tmpTestArray; tmpControlArray];

redPathArray = [redPathArray; tmpRedPathArrayTest; tmpRedPathArrayControl];
yelPathArray = [yelPathArray; tmpYelPathArrayTest; tmpYelPathArrayControl];

end


