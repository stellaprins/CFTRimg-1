function resultsStructArray = populateResultsQuench( resultsStructArray...
	,plateStructArray)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

conditionN	= length(resultsStructArray);
plateN			= length(plateStructArray);

for k=1:conditionN
	res = resultsStructArray(k);
	currentCondition = res.mutation;
	countTest			= 1;
	countControl	= 1;
	for j=1:plateN
		wellN = length(plateStructArray(j).imageQuench);
		for i=1:wellN
			well = plateStructArray(j).imageQuench(i);
			if strcmp(well.mutation,currentCondition)
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

