function normStruct = normalizeResultsWT( normStruct , normConditionStr)
%NORMALIZE_RESULTS_WT normalize all conditions to Wild Type to account for
%differences between different plates.
%   If no WT condition is present on a plate, then an error will be raised.

cellN				= length(normStruct.mutation);
% create a vector giving true/false for whether each cell is 'WT'
% (determined by normConditionStr)
		locationWT	= zeros(cellN,1);
		for i = 1:cellN
			locationWT(i) = strcmp(normConditionStr,normStruct.mutation{i});
		end
		if sum(locationWT) == 0
			fprintf('This plate does not contain "%s" condition and will not be normalized\n'...
				,normConditionStr)
			return
		end

% % % create a vector giving true/false for whether each cell is 'WT 28'
% % 		locationWT28	= zeros(cellN,1);
% % 		for i = 1:cellN
% % 			locationWT28(i) = strcmp('WT 28',normStruct.mutation{i});
% % 		end
% % 		if sum(locationWT28) == 0
% % 			fprintf('This plate does not contain WT at 28°C')
% % 			return
% % 		end

%			calculate metrics for WT condition (membrane and entire)
yelEntireWT				= locationWT .* normStruct.yelEntire;
yelMembraneWT			= locationWT .* normStruct.yelMembrane;
redEntireWT				= locationWT .* normStruct.redEntire;
yelEntireWT(yelEntireWT==0)			= []; %			remove zeros
yelMembraneWT(yelMembraneWT==0) = [];
redEntireWT(redEntireWT==0)			= [];
medianRedEntireWT		= median(redEntireWT);% calculate median F-YFP-entire and median F-mCh-entire for WT
medianYelEntireWT		= median(yelEntireWT);
% % %			28°C
% % yelEntireWT28				= locationWT28 .* normStruct.yelEntire;
% % yelMembraneWT28			= locationWT28 .* normStruct.yelMembrane;
% % redEntireWT28				= locationWT28 .* normStruct.redEntire;
% % yelEntireWT28(yelEntireWT28==0)			= []; %			remove zeros
% % yelMembraneWT28(yelMembraneWT28==0) = [];
% % redEntireWT28(redEntireWT28==0)			= [];
% % medianRedEntireWT28		= median(redEntireWT28); % calculate median F-YFP-entire and median F-mCh-entire for WT
% % medianYelEntireWT28		= median(yelEntireWT28);
	
% Normalise the YFP entire and mCh entire of each cell to the average F-YFP-entire and mean F-mCh-entire for WT
normStruct.yelEntire		= normStruct.yelEntire		./ medianYelEntireWT;
normStruct.yelMembrane	= normStruct.yelMembrane	./ medianYelEntireWT;
normStruct.redEntire		= normStruct.redEntire		./ medianRedEntireWT;
normStruct.memDens			= normStruct.yelMembrane	./ normStruct.redEntire;
normStruct.logMemDens		= log10(normStruct.memDens);

% % % create a vector giving true (1) for 28 degrees and false (0) for 37
% % % degrees
% % 		locationTemp	= zeros(cellN,1);
% % 		for i = 1:cellN
% % 			locationTemp = normStruct.cellLocation(:,2)==28;
% % 		end
% % 		if sum(locationTemp) == 0
% % 			fprintf('This plate does not contain 28°C')
% % 			return
% % 		end

end

% memDensWT					=	locationWT .* normStruct.memDens;
% logMemDensWT			= locationWT .* normStruct.logMemDens;
% meanLogMemDensWT = nansum(logMemDensWT) / sum(locationWT);

% memDensWT28					=	locationWT28 .* normStruct.memDens;
% logMemDensWT28			= locationWT28 .* normStruct.logMemDens;
% meanLogMemDensWT28 = nansum(logMemDensWT) / sum(locationWT);

% backtransform the mean of the log(F(YFP-membrane)/F(mCherry-total))
% meanMemDensWT	= 10^(nansum(logMemDensWT) / sum(locationWT)); 

% % calculate the normalization constant
% norm	= 1 / meanMemDensWT;

% % multiply all cells (for all conditions) by normalization constant
%  normStruct.normMemDens			= normStruct.memDens * norm;
%  normStruct.logNormMemDens  = real(log10(normStruct.memDens * norm));
 


