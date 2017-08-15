function imageStructArray = createImageQuenchStruct(...
	redPathArrayTest,yelPathArrayTest...
		,redPathArrayControl,yelPathArrayControl)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

testN = length(redPathArrayTest);
controlN = length(redPathArrayControl);
pathN = testN+controlN;

imageTemplate = struct(...
			'test_control',[]...
			,'redPath',{{}}...
			,'yelPath',{{}}...
			,'yelInsideOverT',[]...
			,'redMaskChange',[]...
			,'maxGradIodine',[]...
			,'maxGradLocation',[]...
			);

imageStructArray(1:pathN,1) = imageTemplate;

for i=1:testN
	imageStructArray(i).test_control = 'test';
	imageStructArray(i).redPath = redPathArrayTest(i,:);
	imageStructArray(i).yelPath = yelPathArrayTest(i,:);
end

for i=1:controlN
	imageStructArray(testN+i).test_control = 'control';
	imageStructArray(testN+i).redPath = redPathArrayControl(i,:);
	imageStructArray(testN+i).yelPath = yelPathArrayControl(i,:);
end

end

