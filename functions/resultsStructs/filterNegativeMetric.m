function [ normStruct ] = filterNegativeMetric( normStruct )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

cellN = length(normStruct.mutation);

yelEntireCompare		= normStruct.yelEntire < 0;
yelMembraneCompare	= normStruct.yelMembrane < 0;
redEntireCompare		= normStruct.redEntire < 0;

toDelete = yelEntireCompare | yelMembraneCompare | redEntireCompare;

newCellN				= cellN - sum(toDelete);

newMutation			= cell(newCellN,1);
newYelEntire		= zeros(newCellN,1);
newYelMembrane	= zeros(newCellN,1);
newRedEntire		= zeros(newCellN,1);

counter = 1;
for i=1:cellN
	
	if toDelete(i) == 0
		
		newMutation(counter)		= normStruct.mutation(i);
		newYelEntire(counter)		= normStruct.yelEntire(i);
		newYelMembrane(counter) = normStruct.yelMembrane(i);
		newRedEntire(counter)		= normStruct.redEntire(i);
		counter = counter + 1;
		
	end

end

normStruct.mutation			= newMutation;
normStruct.yelEntire		= newYelEntire;
normStruct.yelMembrane	= newYelMembrane;
normStruct.redEntire		= newRedEntire;

end

