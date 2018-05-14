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

%			calculate metrics for WT condition (membrane and entire)
yelEntireWT				= locationWT .* normStruct.yelEntire;
yelMembraneWT			= locationWT .* normStruct.yelMembrane;
redEntireWT				= locationWT .* normStruct.redEntire;
memDensWT					=	locationWT .* normStruct.memDens;
logMemDensWT			= locationWT .* normStruct.logMemDens;

yelEntireWT(yelEntireWT==0)			=[];
yelMembraneWT(yelMembraneWT==0)	=[];
redEntireWT(redEntireWT==0)			=[];
memDensWT(memDensWT==0)					=[];
logMemDensWT(logMemDensWT==0)		=[];

meanYFPMembraneWT		= nansum(yelMembraneWT ./ redEntireWT) / sum(locationWT);
meanYFPEntireWT			= nansum(yelEntireWT ./ redEntireWT) / sum(locationWT);
medianYFPMembraneWT	= median((yelMembraneWT ./ redEntireWT) );
medianYFPEntireWT		= median((yelEntireWT ./ redEntireWT) );

% backtransform the mean of the log(F(YFP-membrane)/F(mCherry-total))
meanlogMemDensWT	= 10^(nansum(logMemDensWT) / sum(locationWT)); 

% calculate the normalization constant (meanlogMemDensWT!)
norm	= 1 / meanlogMemDensWT;

% multiply all cells (for all conditions) by normalization constant
 normStruct.normMemDens			= normStruct.memDens * norm;
 normStruct.logNormMemDens  = real(log10(normStruct.memDens * norm));
end

