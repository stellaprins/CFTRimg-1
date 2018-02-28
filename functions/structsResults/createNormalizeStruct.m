function normStructArray = createNormalizeStruct( plateStructArray )
%CREATE_NORMALIZE_STRUCT initializes empty structs for data in preparation
%for the normalization to WT process
%   The structs are dummy, temporary structures to store the data while it
%   is being normalized.

plateN = length(plateStructArray);

normalizeTemplate = struct(...
			'mutation',{{}}...
			,'cellLocation',[]...
			,'yelEntire',[]...
			,'yelMembrane',[]...
			,'redEntire',[]);
		
for j=1:plateN
	
	plateStruct = plateStructArray(j);
	normStructArray(j) = normalizeTemplate;
	
	for i=1:length(plateStruct.imageLocal)
		
		cellN = plateStruct.imageLocal(i).cellN(end);
		tmp(1:cellN,1) = {plateStruct.imageLocal(i).mutation};
		normStructArray(j).mutation = vertcat(normStructArray(j).mutation,tmp);
		clear tmp
		
		normStructArray(j).cellLocation = vertcat(normStructArray(j).cellLocation...
			,plateStruct.imageLocal(i).cellLocation);
		normStructArray(j).yelEntire = vertcat(normStructArray(j).yelEntire...
			,plateStruct.imageLocal(i).yelEntire);
		normStructArray(j).yelMembrane = vertcat(normStructArray(j).yelMembrane...
			,plateStruct.imageLocal(i).yelMembrane);
		normStructArray(j).redEntire = vertcat(normStructArray(j).redEntire...
			,plateStruct.imageLocal(i).redEntire);
	end
	
end
	
end