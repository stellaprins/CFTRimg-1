function resultsStructArray = createResultsQuenchStruct( conditionStructArray )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

conditionN = length(conditionStructArray);
resultsTemplate = struct(...
			'mutation',[]...
			,'maxGradTest',[]...
			,'maxGradControl',[]...
			,'maxGradTestLoc',[]...
			,'maxGradControlLoc',[]);
		
for i=1:conditionN
	resultsStructArray(i) = resultsTemplate;
end

for i=1:conditionN

	condStruct = conditionStructArray(i);
	
	resultsStructArray(i).mutation = condStruct.mutation{1};
	
	testLogical = zeros(length(condStruct.imageQuench),1);
	for a=1:length(condStruct.imageQuench)
		testLogical(a) = strcmp(condStruct.imageQuench(a).test_control,'test');
	end
	
	maxGradTest = zeros(sum(testLogical),1);
	maxGradControl = zeros(length(testLogical) - sum(testLogical),1);
	maxGradTestLoc = zeros(sum(testLogical),1);
	maxGradControlLoc = zeros(length(testLogical) - sum(testLogical),1.);
	
	maxGrad = vertcat(condStruct.imageQuench.maxGradIodine);
	maxGradLoc = vertcat(condStruct.imageQuench.maxGradLocation);
	
	counterTest = 1;
	counterControl = 1;
	for a=1:length(testLogical)
		if testLogical(a) == 1
			maxGradTest(counterTest) = maxGrad(a);
			maxGradTestLoc(counterTest) = maxGradLoc(a);
			counterTest = counterTest + 1;
		elseif testLogical(a) == 0
			maxGradControl(counterControl) = maxGrad(a);
			maxGradControlLoc(counterControl) = maxGradLoc(a);
			counterControl = counterControl + 1;
		end
	end
	
	resultsStructArray(i).maxGradTest = maxGradTest;
	resultsStructArray(i).maxGradControl = maxGradControl;
	resultsStructArray(i).maxGradTestLoc = maxGradTestLoc;
	resultsStructArray(i).maxGradControlLoc = maxGradControlLoc;
	
	
end
	
end

