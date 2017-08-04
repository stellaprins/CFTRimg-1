function imageStruct = createImageQuenchStruct(redPathArray , yelPathArray)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

pathN = length(redPathArray);
imageTemplate = struct(...
			'redPath',{{}}...
			,'yelPath',{{}}...
			);

imageStruct(1:pathN,1) = imageTemplate;

for i=1:pathN
	imageStruct(i).redPath = redPathArray(i,:);
	imageStruct(i).yelPath = yelPathArray(i,:);
end

end

