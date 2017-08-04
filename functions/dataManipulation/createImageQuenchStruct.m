function imageStruct = createImageQuenchStruct(...)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

wellN = length(wells);
imageTemplate = struct(...
			'yelPaths', {{}}...
			,'redPaths', {{}}...
	);

imageStruct(1:pathN,1) = imageTemplate;

for i=1:wellN
	imageStruct(i).redPath = redPathArray{i};
	imageStruct(i).yelPath = yelPathArray{i};
end

end

end

