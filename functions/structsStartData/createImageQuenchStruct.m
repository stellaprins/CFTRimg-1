function imageStructArray = createImageQuenchStruct(...
	mutationArray,test_controlArray...
	,redPathArray,yelPathArray)
%CREATE_IMAGE_QUENCH_STRUCT initializes empty struct for each quench well
%   Defines all attributes of image_quench struct and assigns initial data
%   to appropriate attributes.

pathN = size(redPathArray,1);

imageTemplate = struct(...
			'mutation',''...
			,'test_control',''...
			,'redPath',{{}}...
			,'yelPath',{{}}...
			,'yelInsideOverT',[]...
			,'redMaskChange',[]...
			,'maxGradIodine',[]...
			,'maxGradLocation',[]...
			);

imageStructArray(1:pathN,1) = imageTemplate;

for i=1:pathN
	imageStructArray(i).mutation = mutationArray{i};
	imageStructArray(i).test_control = test_controlArray{i};
	imageStructArray(i).redPath = redPathArray(i,:);
	imageStructArray(i).yelPath = yelPathArray(i,:);
end

end

