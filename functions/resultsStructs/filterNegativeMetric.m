function imageStruct = filterNegativeMetric( imageStruct )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

cellN = imageStruct.cellN(end);

yelEntireCompare		= imageStruct.yelEntire < 0;
yelMembraneCompare	= imageStruct.yelMembrane < 0;
redEntireCompare		= imageStruct.redEntire < 0;

toDelete = yelEntireCompare | yelMembraneCompare | redEntireCompare;

newCellN				= cellN - sum(toDelete);

newBoundingBox	= zeros(newCellN,4);
newRedEntire		= zeros(newCellN,1);
newRedOutside		= zeros(newCellN,1);
newYelEntire		= zeros(newCellN,1);
newYelOutside		= zeros(newCellN,1);
newYelMembrane	= zeros(newCellN,1);
newYelInterior	= zeros(newCellN,1);

counter = 1;
for i=1:cellN
	
	if toDelete(i) == 0
		
		newBoundingBox(counter,:)		= imageStruct.boundingBox(i,:);
		newRedEntire(counter)				= imageStruct.redEntire(i);
		newRedOutside(counter)			= imageStruct.redOutside(i);
		newYelEntire(counter)				= imageStruct.yelEntire(i);
		newYelOutside(counter)			= imageStruct.yelOutside(i);
		newYelMembrane(counter)			= imageStruct.yelMembrane(i);
		newYelInterior(counter)			= imageStruct.yelInterior(i);
		
		counter = counter + 1;
		
	end

end

imageStruct.boundingBox			= newBoundingBox;
imageStruct.redEntire				= newRedEntire;
imageStruct.redOutside			= newRedOutside;
imageStruct.yelEntire				= newYelEntire;
imageStruct.yelEntire				= newYelEntire;
imageStruct.yelMembrane			= newYelMembrane;
imageStruct.yelEntire				= newYelEntire;
imageStruct.cellN(1,end+1)	= newCellN;

end


