function  imageStruct = createImageStruct( pathArray )
%CREATECONDITIONS create empty structs for each conditions as listed in
%'conditionsStr'

pathN = length(pathArray);
imageTemplate = struct(...
			'path',''...
			,'boundingBox',{{}} ...
			,'cellWidth',[] ...
			,'cellLength',[] ...
			,'cellN',[] ...
			);

for i=1:pathN
	imageStruct(i,1) = imageTemplate;
	imageStruct(i).path = pathArray{i};
	
end

end

