function normStructArray = normalizeResultsWT(normStructArray,...
	normConditionStr)
%NORMALIZE_RESULTS_WT normalize all conditions to that specified by
%"normConditionStr" to account for differences between different plates.
%   If the normalizing condition is not present on a plate, then an error
%   will be raised.

normCondN = length(normConditionStr);
expN = length(normStructArray) / normCondN;

for k=1:normCondN
	
	currentNormCond = normConditionStr{k};

	for j=1:expN
		
		normStruct = normStructArray((k-1)*expN + j);
		
		cellN				= length(normStruct.condition);

		% create a vector giving true/false for whether each cell is the
		% normalizing condition, normally 'WT'
		locationWT	= zeros(cellN,1);
		for i = 1:cellN
			locationWT(i) = strcmp(currentNormCond,normStruct.condition{i});
		end

		if sum(locationWT) == 0
			fprintf('This plate does not contain "%s" condition and will not be normalized\n'...
				,normConditionStr)

			% calculate metrics using the NON-normalized data
			normStruct.memDens			= normStruct.yelMembrane	./ normStruct.redEntire;
			normStruct.logMemDens		= log10(normStruct.memDens);

			return
		end

		%	calculate the median for WT condition (red and yel entire)
		yelEntireWT										= locationWT .* normStruct.yelEntire;
		redEntireWT										= locationWT .* normStruct.redEntire;
		yelEntireWT(yelEntireWT==0)		= []; % remove zeros
		redEntireWT(redEntireWT==0)		= [];
		medianRedEntireWT							= median(redEntireWT);
		medianYelEntireWT							= median(yelEntireWT);

		% normalize the YFP entire and mCh entire of each cell to the median
		% F-YFP-entire and F-mCh-entire for WT
		normStruct.yelEntire		= normStruct.yelEntire		/ medianYelEntireWT;
		normStruct.yelMembrane	= normStruct.yelMembrane	/ medianYelEntireWT;
		normStruct.redEntire		= normStruct.redEntire		/ medianRedEntireWT;

		% calculate key metrics using the normalized data (i.e. the membrane
		% density and the log of the membrane density)
		normStruct.memDens			= normStruct.yelMembrane	./ normStruct.redEntire;
		normStruct.logMemDens		= log10(normStruct.memDens);
		
		normStructArray((k-1)*expN + j) = normStruct;
		
	end
	
end

end
