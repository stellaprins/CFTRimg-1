function resultsStructArray = createResultsQuenchStruct( plateStructArray )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


plateN = length(plateStructArray);

% create cell array of mutations across all plates
conditions = cell(0,1);
for i=1:plateN
	conditions = unique(horzcat(conditions,{plateStructArray(i).imageQuench.mutation}));
end

conditionN = length(conditions);

resultsTemplate = struct(...
			'mutation',''...
			,'maxGradTest',[]...
			,'maxGradControl',[]...
			,'maxGradTestLoc',[]...
			,'maxGradControlLoc',[]...
			,'yelInsideOverTTest',[]...
			,'yelInsideOverTControl',[]);
		
% find out how many wells per condition across all plates
wellsPerConditionPlateTest = zeros(plateN,conditionN);
wellsPerConditionPlateControl = zeros(plateN,conditionN);

for k=1:conditionN
	currentCondition = conditions{k};
	for j=1:plateN
		wellN = length(plateStructArray(j).imageQuench);
		for i=1:wellN
			if strcmp(plateStructArray(j).imageQuench(i).mutation,currentCondition)
				switch plateStructArray(j).imageQuench(i).test_control
					case 'test'
						wellsPerConditionPlateTest(j,k) = ...
							wellsPerConditionPlateTest(j,k) + 1;
					case 'control'
						wellsPerConditionPlateControl(j,k) = ...
							wellsPerConditionPlateControl(j,k) + 1;
				end
			end
		end
	end
end
		
for i=1:conditionN
	
	resultsStructArray(i) = resultsTemplate;
	resultsStructArray(i).mutation  = conditions{i};
	
	wellTestN			= sum(wellsPerConditionPlateTest(:,i));
	wellControlN	= sum(wellsPerConditionPlateControl(:,i));
	
	resultsStructArray(i).maxGradTest						= zeros(wellTestN,1);
	resultsStructArray(i).maxGradTestLoc				= zeros(wellTestN,1);
	resultsStructArray(i).yelInsideOverTTest		= zeros(wellTestN,70);
	resultsStructArray(i).maxGradControl				= zeros(wellControlN,1);
	resultsStructArray(i).maxGradControlLoc			= zeros(wellControlN,1);
	resultsStructArray(i).yelInsideOverTControl = zeros(wellControlN,70);
	
end

end

