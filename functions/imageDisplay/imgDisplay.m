function imgDisplay( imageStruct )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

image = imread(imageStruct.redPath);

doubleImage = im2double(image);

adjusted = imadjust(doubleImage,[min(doubleImage(:)); max(doubleImage(:))]...
	,[0; 1]);

imshow(adjusted)

end

