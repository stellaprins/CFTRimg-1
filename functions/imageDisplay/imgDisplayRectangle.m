function imgDisplayRectangle( imageStruct,color,boundingBox1,boundingBox2 )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

global EXTRA

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

BB = boundingBox1;
BB(1) = ceil(BB(1)) - EXTRA;
BB(2) = ceil(BB(2)) - EXTRA;
BB(3) = BB(3) + EXTRA*2;
BB(4) = BB(4) + EXTRA*2;

CC = boundingBox2;
CC(1) = ceil(CC(1)) - EXTRA;
CC(2) = ceil(CC(2)) - EXTRA;
CC(3) = CC(3) + EXTRA*2;
CC(4) = CC(4) + EXTRA*2;


imshow(image,[])
rectangle('Position',BB,...
			'EdgeColor','w',...
	'LineWidth', 2,...
	'LineStyle','-')
rectangle('Position',CC,...
			'EdgeColor','w',...
	'LineWidth', 2,...
	'LineStyle','-')

end

