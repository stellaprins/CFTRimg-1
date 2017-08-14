function imgDisplay( imageStruct , color )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


switch color
	case 'red'
		image = imadjust(im2double(imread(imageStruct.redPath)));
		[imX,map] = gray2ind(image,256);
		redMap = [map(:,1),zeros(256,1),zeros(256,1)];
		image = ind2rgb(imX,redMap);
	case 'yel'
		image = imadjust(im2double(imread(imageStruct.yelPath)));
		[imX,map] = gray2ind(image,256);
		yelMap = [map(:,1),map(:,1),zeros(256,1)];
		image = ind2rgb(imX,yelMap);
	otherwise
		disp('Please enter "red" or "yel" as the second argument of imgDisplay.')
end

imshow(image,[],'InitialMagnification','fit')

end

