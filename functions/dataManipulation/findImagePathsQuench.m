function [ mutationArray,test_controlArray,redPathArray,yelPathArray] = ...
	findImagePathsQuench(experimentStruct,mutationArray,test_controlArray ...
	,redPathArray,yelPathArray)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

redTimePoints = {'1','70'};

wellsTest = {experimentStruct.condWells{:}};
emptyCellsTest = cellfun('isempty',wellsTest);
wellsTest(emptyCellsTest) = [];
wellsTestN = length(wellsTest);

wellsControl = {experimentStruct.condWellsControl{:}};
emptyCellsControl = cellfun('isempty',wellsControl);
wellsControl(emptyCellsControl) = [];
wellsControlN = length(wellsControl);

tmpTestArray						= cell(wellsTestN,1);
tmpControlArray					= cell(wellsControlN,1);
tmpRedPathArrayTest			= cell(wellsTestN,2);
tmpYelPathArrayTest			= cell(wellsTestN,70);
tmpRedPathArrayControl	= cell(wellsControlN,2);
tmpYelPathArrayControl	= cell(wellsControlN,70);

tmpMutationArray				= cell(wellsTestN,1);

for j=1:wellsTestN

	% construct the path names for the test condition wells
	[tmpRedPathArrayTest,tmpYelPathArrayTest] = ...
		constructPathNameQuench(experimentStruct,wellsTest,j,redTimePoints...
		,tmpRedPathArrayTest,tmpYelPathArrayTest);
	
	% create constant array of 'test' labels
	tmpTestArray{j} = 'test';
	
	% find current mutation for this well
	locationMatrix = strcmp(wellsTest{j},experimentStruct.condWells);
	for i=1:size(experimentStruct.condWells,1)
		if sum(locationMatrix(i,:)) == 1
			tmpMutationArray{j} = experimentStruct.conditionStr{i};
		end
	end

end

mutationArray = [mutationArray; tmpMutationArray];

tmpMutationArray				= cell(wellsControlN,1);

for j=1:wellsControlN
 
	% construct the path names for the control condition wells
	[tmpRedPathArrayControl,tmpYelPathArrayControl] = ...
		constructPathNameQuench(experimentStruct,wellsControl,j,redTimePoints...
		,tmpRedPathArrayControl,tmpYelPathArrayControl);
	
	% create constant array of 'control' labels
	tmpControlArray{j} = 'control';
	
	% find current mutation for this well
	locationMatrix = strcmp(wellsControl{j},experimentStruct.condWellsControl);
	for i=1:size(experimentStruct.condWellsControl,1)
		if sum(locationMatrix(i,:)) == 1
			tmpMutationArray{j} = experimentStruct.conditionStr{i};
		end
	end

end

mutationArray = [mutationArray; tmpMutationArray];
test_controlArray = [test_controlArray; tmpTestArray; tmpControlArray];

redPathArray = [redPathArray; tmpRedPathArrayTest; tmpRedPathArrayControl];
yelPathArray = [yelPathArray; tmpYelPathArrayTest; tmpYelPathArrayControl];

end


