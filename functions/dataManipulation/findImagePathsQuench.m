function [ redPathArrayTest,yelPathArrayTest...
	,redPathArrayControl,yelPathArrayControl] = findImagePathsQuench( ...
	conditionLocation,experimentStruct...
	,redPathArrayTest,yelPathArrayTest...
	,redPathArrayControl,yelPathArrayControl)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

redTimePoints = {'1','70'};

wellsTest = {experimentStruct.condWells{conditionLocation,:}};
wellsControl = {experimentStruct.condWellsControl{conditionLocation,:}};

wellsTestN = sum(~cellfun(@isempty,experimentStruct.condWells(conditionLocation,:)));
wellsControlN = sum(~cellfun(@isempty,experimentStruct.condWellsControl(conditionLocation,:)));

tmpRedPathArrayTest = cell(wellsTestN,2);
tmpYelPathArrayTest = cell(wellsTestN,70);
tmpRedPathArrayControl = cell(wellsControlN,2);
tmpYelPathArrayControl = cell(wellsControlN,70);

for j=1:wellsTestN

	[tmpRedPathArrayTest,tmpYelPathArrayTest] = ...
		constructPathNameQuench(experimentStruct,wellsTest,j,redTimePoints...
		,tmpRedPathArrayTest,tmpYelPathArrayTest);

end

for j=1:wellsControlN

	[tmpRedPathArrayControl,tmpYelPathArrayControl] = ...
		constructPathNameQuench(experimentStruct,wellsControl,j,redTimePoints...
		,tmpRedPathArrayControl,tmpYelPathArrayControl);

end

redPathArrayTest = [redPathArrayTest; tmpRedPathArrayTest];
yelPathArrayTest = [yelPathArrayTest; tmpYelPathArrayTest];

redPathArrayControl = [redPathArrayControl; tmpRedPathArrayControl];
yelPathArrayControl = [yelPathArrayControl; tmpYelPathArrayControl];

end


