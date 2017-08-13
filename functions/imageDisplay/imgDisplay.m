function imgDisplay( imageStruct , color )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


switch color
	case 'red'
		image = imread(imageStruct.redPath);
	case 'yel'
		image = imread(imageStruct.yelPath);
	otherwise
		disp('Please enter "red" or "yel" as the second argument of imgDisplay.')
end

imshow(image,[],'InitialMagnification','fit')

end

