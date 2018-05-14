function normStruct = normalizeResultsWT( normStruct , normConditionStr)
%NORMALIZE_RESULTS_WT normalize all conditions to Wild Type to account for
%differences between different plates.
%   If no WT condition is present on a plate, then an error will be raised.

cellN				= length(normStruct.mutation);

% create a vector giving true/false for whether each cell is 'WT'
locationWT	= zeros(cellN,1);
for i = 1:cellN
	locationWT(i) = strcmp(normConditionStr,normStruct.mutation{i});
end

if sum(locationWT) == 0
	fprintf('This plate does not contain "%s" condition and will not be normalized\n'...
		,normConditionStr)
	return
end

% calculate metrics for WT condition (membrane and entire)
%			Here we are normalizing to the mCherry
yelEntireWT				= locationWT .* normStruct.yelEntire;
yelMembraneWT			= locationWT .* normStruct.yelMembrane;
redEntireWT				= locationWT .* normStruct.redEntire;
memDensWT					=	locationWT .* normStruct.memDens;
logMemDensWT			= locationWT .* normStruct.logMemDens;

meanLogMemDensWT = nansum(logMemDensWT) / sum(locationWT);

% backtransform the mean of the log(F(YFP-membrane)/F(mCherry-total))
meanMemDensWT	= 10^(nansum(logMemDensWT) / sum(locationWT)); 

% calculate the normalization constant
norm	= 1 / meanMemDensWT;

% multiply all cells (for all conditions) by normalization constant
normStruct.normMemDens			= normStruct.memDens * norm;
normStruct.logNormMemDens  = real(log10(normStruct.memDens * norm));

end

