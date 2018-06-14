function resultsStructArray = populateResultsQuench( resultsStructArray...
	,expStructArray)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

conditionN	= length(resultsStructArray);
expN			= length(expStructArray);

for k=1:conditionN
	res = resultsStructArray(k);
	currentCondition = res.condition;
	countTest			= 1;
	countControl	= 1;
	for j=1:expN
		wellN = length(expStructArray(j).imageQuench);
		for i=1:wellN
			well = expStructArray(j).imageQuench(i);
			if strcmp(well.condition,currentCondition)
				switch well.test_control
					case 'test'
						res.maxGradTest(countTest)							= well.maxGradIodine;
						res.maxGradTestLoc(countTest)						= well.maxGradLocation;
						res.yelInsideOverTTest(countTest,:)			= well.yelInsideOverT';
						countTest																= countTest + 1;
					case 'control'
						res.maxGradControl(countControl)				= well.maxGradIodine;
						res.maxGradControlLoc(countControl)			= well.maxGradLocation;
						res.yelInsideOverTControl(countControl,:)	= well.yelInsideOverT';
						countControl														= countControl + 1;
				end
			end
		end
	end
	resultsStructArray(k) = res;
end


end

