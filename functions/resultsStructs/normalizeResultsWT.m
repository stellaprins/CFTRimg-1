function normStruct = normalizeResultsWT( normStruct , normConditionStr)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

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
meanYFPMembraneWT	= nansum(yelMembraneWT ./ redEntireWT) / sum(locationWT);
meanYFPEntireWT		= nansum(yelEntireWT ./ redEntireWT) / sum(locationWT);

% calculate the normalization constant
normalizeMembrane	= 1 / meanYFPMembraneWT;
normalizeEntire		= 1 / meanYFPEntireWT;


% multiply all cells (for all conditions) by normalization constant
normStruct.yelMembrane	= normStruct.yelMembrane * normalizeMembrane;
normStruct.yelEntire		= normStruct.yelEntire * normalizeEntire;

end

