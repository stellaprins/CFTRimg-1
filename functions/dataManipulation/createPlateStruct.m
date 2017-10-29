function  plateStruct = createPlateStruct( experimentStruct )
%CREATEPLATE create empty structs for each plate as listed in
%'experimentStruct.plateStr'

plates = unique(horzcat(experimentStruct.plateStr));

plateN = length(plates);
plateTemplate = struct(...
			'plateStr',{{}}...
			,'imageLocal',{{}}...
			,'imageQuench',{{}});

for i=1:plateN
	plateStruct(i) = plateTemplate;
	plateStruct(i).plateStr = plates{i};
end


