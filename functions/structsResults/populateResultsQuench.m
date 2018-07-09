function resultsStructArray = populateResultsQuench( resultsStructArray...
	,plateStructArray)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

conditionN	= length(resultsStructArray);
plateN			= length(plateStructArray);

for k=1:conditionN
	res = resultsStructArray(k);
	currentCondition = res.condition;
	countTest			= 1;
	countControl	= 1;
	for j=1:plateN
		wellN = length(plateStructArray(j).well);
		for i=1:wellN
			well = plateStructArray(j).well(i);
			timePointN = length(well.yelInsideOverT);
			if strcmp(well.conditionStr,currentCondition)
				switch well.test_control
					case 'test'
						res.maxGradTest(countTest)							= well.maxGradIodine;
						res.maxGradTestLoc(countTest)						= well.maxGradLocation;
						for t=1:timePointN
							res.yelInsideOverTTest(countTest,t)		= well.yelInsideOverT(t);
						end
						countTest																= countTest + 1;
					case 'control'
						res.maxGradControl(countControl)						= well.maxGradIodine;
						res.maxGradControlLoc(countControl)					= well.maxGradLocation;
						for t=1:timePointN
							res.yelInsideOverTControl(countControl,t)	= well.yelInsideOverT(t);
						end
						countControl																= countControl + 1;
				end
			end
		end
	end
	resultsStructArray(k) = res;
end


end

