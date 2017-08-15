function [ imageStruct ] = imgFilterRedGrad( imageStruct )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

image = im2double(imread(imageStruct.redPath));

[ maxGradient , ~ ] = findGradient( imageStruct );

counter = 1;
for idx=1:imageStruct.cellN(end)
	
	boundingBox = imageStruct.boundingBox(idx,:);
	
	redCropped = boundingBoxToCroppedImage(image,boundingBox);
	
	redMin = min(redCropped(:));
	redMax = max(redCropped(:));
	
	refGradient = (redMax - redMin) / 40;
	
	if maxGradient(idx) > refGradient 
		imageStruct.boundingBox(counter,:) = imageStruct.boundingBox(idx,:);
		counter = counter + 1;
	end
	
end
	
imageStruct.cellN(1,end+1) = counter - 1;

end
	

