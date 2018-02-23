function imgDisplayRectangle( imageStruct,color,BB)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

X=BB;
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

imshow(image,[])
hold on
for i = 1:size(X,1)
BB=X;
BB = BB(i,:);
BB(1) = ceil(BB(1)) ;
BB(2) = ceil(BB(2)) ;
BB(3) = BB(3) ;
BB(4) = BB(4) ;
rectangle('Position',BB,...
			'EdgeColor','w',...
	'LineWidth', 2,...
	'LineStyle','-')
hold on
end
end
