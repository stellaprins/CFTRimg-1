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
	case 'blend'
		yel = imadjust(im2double(imread(imageStruct.yelPath)));
		red = imadjust(im2double(imread(imageStruct.redPath)));
		[yelIm,map] = gray2ind(yel,256);
		yelMap = [map(:,1),map(:,1),zeros(256,1)];
		yelOut = ind2rgb(yelIm,yelMap);
		[redIm,map] = gray2ind(red,256);
		redMap = [map(:,1),zeros(256,1),zeros(256,1)];
		redOut = ind2rgb(redIm,redMap);
		image = imfuse(yelOut,redOut,'blend');
	case 'combine'
		yel = imadjust(im2double(imread(imageStruct.yelPath)));
		red = imadjust(im2double(imread(imageStruct.redPath)));
		image = zeros(2160,2160,3);
		image(:,:,1) = red + yel;
		image(:,:,2) = yel;
	otherwise
		disp('Please enter "red", "yel", "blend" or "combine" as the second argument of imgDisplay.')
end

imshow(image,[])

end

