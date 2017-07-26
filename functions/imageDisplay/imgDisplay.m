function imgDisplay( imageStruct )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

image = imread(imageStruct.redPath);

imshow(image,[],'InitialMagnification','fit')

end

