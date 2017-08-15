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

tmpRedPathArrayTest = cell(length(wellsTest),2);
tmpYelPathArrayTest = cell(length(wellsTest),70);
tmpRedPathArrayControl = cell(length(wellsControl),2);
tmpYelPathArrayControl = cell(length(wellsControl),70);

for j=1:length(wellsTest)

	[tmpRedPathArrayTest,tmpYelPathArrayTest] = ...
		constructPathNameQuench(experimentStruct,wellsTest,j,redTimePoints...
		,tmpRedPathArrayTest,tmpYelPathArrayTest);

end

for j=1:length(wellsControl)

	[tmpRedPathArrayControl,tmpYelPathArrayControl] = ...
		constructPathNameQuench(experimentStruct,wellsControl,j,redTimePoints...
		,tmpRedPathArrayControl,tmpYelPathArrayControl);

end

redPathArrayTest = [redPathArrayTest; tmpRedPathArrayTest];
yelPathArrayTest = [yelPathArrayTest; tmpYelPathArrayTest];

redPathArrayControl = [redPathArrayControl; tmpRedPathArrayControl];
yelPathArrayControl = [yelPathArrayControl; tmpYelPathArrayControl];

end


