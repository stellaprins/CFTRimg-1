function imgDisplayQuench( imageStruct , color )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


switch color
	case 'red'
		image = imadjust(im2double(imread(imageStruct.redPath{1})));
		[imX,map] = gray2ind(image,32);
		redMap = [map(:,1),zeros(32,1),zeros(32,1)];
		image = ind2rgb(imX,redMap);
	case 'yel'
		image = imadjust(im2double(imread(imageStruct.yelPath{1})));
		[imX,map] = gray2ind(image,32);
		yelMap = [map(:,1),map(:,1),zeros(32,1)];
		image = ind2rgb(imX,yelMap);
	case 'bw'
		redImage = imadjust(im2double(imread(imageStruct.redPath{1})));
		image = findCellMask(redImage);
	otherwise
		disp('Please enter "red", "yel" or "bw" as the second argument of imgDisplay.')
end

imshow(image,[])
set(gca,'position',[0 0 1 1])

end

