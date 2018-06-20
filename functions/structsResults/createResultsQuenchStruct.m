function resultsStructArray = createResultsQuenchStruct( expStructArray )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


expN = length(expStructArray);

% create cell array of mutations across all plates
conditions = cell(0,1);
for i=1:expN
	conditions = unique(horzcat(conditions,{expStructArray(i).imageQuench.condition}));
end

conditionN = length(conditions);

resultsTemplate = struct(...
			'condition',''...
			,'maxGradTest',[]...
			,'maxGradControl',[]...
			,'maxGradTestLoc',[]...
			,'maxGradControlLoc',[]...
			,'yelInsideOverTTest',[]...
			,'yelInsideOverTControl',[]);
		
% find out how many wells per condition across all plates
wellsPerConditionExpTest = zeros(expN,conditionN);
wellsPerConditionExpControl = zeros(expN,conditionN);

for k=1:conditionN
	currentCondition = conditions{k};
	for j=1:expN
		wellN = length(expStructArray(j).imageQuench);
		for i=1:wellN
			if strcmp(expStructArray(j).imageQuench(i).condition,currentCondition)
				switch expStructArray(j).imageQuench(i).test_control
					case 'test'
						wellsPerConditionExpTest(j,k) = ...
							wellsPerConditionExpTest(j,k) + 1;
					case 'control'
						wellsPerConditionExpControl(j,k) = ...
							wellsPerConditionExpControl(j,k) + 1;
				end
			end
		end
	end
end

% find the largest number of quench time points across all plates, to
% initialize arrays
maxTimePointN = 0;
for j=1:expN
	expStruct = expStructArray(j);
	wellN = length(expStruct.imageQuench);
	for i=1:wellN
		timePointN = size(expStruct.imageQuench(i).yelPath,2);
		maxTimePointN = max(maxTimePointN,timePointN);
	end
end
		
for i=1:conditionN
	
	resultsStructArray(i) = resultsTemplate;
	resultsStructArray(i).condition  = conditions{i};
	
	wellTestN			= sum(wellsPerConditionExpTest(:,i));
	wellControlN	= sum(wellsPerConditionExpControl(:,i));
	
	resultsStructArray(i).maxGradTest						= zeros(wellTestN,1);
	resultsStructArray(i).maxGradTestLoc				= zeros(wellTestN,1);
	resultsStructArray(i).yelInsideOverTTest		= zeros(wellTestN,maxTimePointN);
	resultsStructArray(i).maxGradControl				= zeros(wellControlN,1);
	resultsStructArray(i).maxGradControlLoc			= zeros(wellControlN,1);
	resultsStructArray(i).yelInsideOverTControl = zeros(wellControlN,maxTimePointN);
	
end

end

