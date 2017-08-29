function imgDisplayOverlayQuench( imageStruct , colorStr )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


switch colorStr
	case 'redOverlay'
		rawImage = imadjust(im2double(imread(imageStruct.redPath{1})));
		[imX,map] = gray2ind(rawImage,32);
		redMap = [map(:,1),zeros(32,1),zeros(32,1)];
		redImage = ind2rgb(imX,redMap);
		thresh = 0.8*graythresh(rawImage);
		Ibw = imbinarize(rawImage,thresh);
		Iedge = edge(Ibw,'sobel');
		image = imoverlay(redImage,Iedge,'w');
	case 'yelStart'
		tmp = im2double(imread(imageStruct.yelPath{4}));
		rawImage = imadjust(im2double(imread(imageStruct.yelPath{1}))...
			,[mean(tmp(:)); 0.5*max(tmp(:))],[0; 1]);
		[imX,map] = gray2ind(rawImage,32);
		yelMap = [map(:,1),map(:,1),zeros(32,1)];
		yelImage = ind2rgb(imX,yelMap);
		cellMask = findCellMask(rawImage);
		Iedge = edge(cellMask,'sobel');
		image = imoverlay(yelImage,Iedge,'w');
	case 'yelEnd'
		tmp = im2double(imread(imageStruct.yelPath{4}));
		rawImage = imadjust(im2double(imread(imageStruct.yelPath{40}))...
			,[mean(tmp(:)); 0.5*max(tmp(:))],[0; 1]);
		[imX,map] = gray2ind(rawImage,32);
		yelMap = [map(:,1),map(:,1),zeros(32,1)];
		yelImage = ind2rgb(imX,yelMap);
		cellMask = findCellMask(rawImage);
		Iedge = edge(cellMask,'sobel');
		image = imoverlay(yelImage,Iedge,'w');
	otherwise
		disp('Please enter "redOverlay", "yelStart" or "yelEnd" as the second argument of imgDisplay.')
end

imshow(image,[])
set(gca,'position',[0 0 1 1])

end

