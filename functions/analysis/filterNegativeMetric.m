function [ resultsStruct ] = filterNegativeMetric( resultsStruct )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

yelEntireCompare = resultsStruct.yelEntire < 0;
yelMembraneCompare = resultsStruct.yelMembrane < 0;
redEntireCompare = resultsStruct.redEntire < 0;

toDelete = yelEntireCompare | yelMembraneCompare | redEntireCompare;

newCellN = resultsStruct.localCellN - sum(toDelete);
newYelEntire = zeros(newCellN,1);
newYelMembrane = zeros(newCellN,1);
newRedEntire = zeros(newCellN,1);

counter = 1;
for i=1:resultsStruct.localCellN
	
	if toDelete(i) == 0
		
		newYelEntire(counter) = resultsStruct.yelEntire(i);
		newYelMembrane(counter) = resultsStruct.yelMembrane(i);
		newRedEntire(counter) = resultsStruct.redEntire(i);
		counter = counter + 1;
		
	end

end

resultsStruct.yelEntire = newYelEntire;
resultsStruct.yelMembrane = newYelMembrane;
resultsStruct.redEntire = newRedEntire;
resultsStruct.localCellN = newCellN;


end

