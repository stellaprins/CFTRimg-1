function showQuenchImage( imageStruct )
%SHOW_IMAGE_QUENCH Display red image, yel at the start and yel at the end,
%with the outline of the cell mask superimposed.
%   WARNING: This function will open many figure windows!

redStart = imadjust(im2double(imread(imageStruct.redPath{1})));
[redImX,map] = gray2ind(redStart,32);
redMap = [map(:,1),zeros(32,1),zeros(32,1)];
redImage = ind2rgb(redImX,redMap);
	

normYel = im2double(imread(imageStruct.yelPath{4}));

yelStart = imadjust(im2double(imread(imageStruct.yelPath{1}))...
	,[mean(normYel(:)); 0.5*max(normYel(:))],[0; 1]);
[yelStartImX,map] = gray2ind(yelStart,32);
yelStartMap = [map(:,1),map(:,1),zeros(32,1)];
yelStartImage = ind2rgb(yelStartImX,yelStartMap);

yelEnd = imadjust(im2double(imread(imageStruct.yelPath{70}))...
	,[mean(normYel(:)); 0.5*max(normYel(:))],[0; 1]);
[yelEndImX,map] = gray2ind(yelEnd,32);
yelEndMap = [map(:,1),map(:,1),zeros(32,1)];
yelEndImage = ind2rgb(yelEndImX,yelEndMap);
	
	
cellMask = findCellMask(redStart);
cellEdge = edge(cellMask,'sobel');


figure
subplot(1,3,1)
	imshow(imoverlay(redImage,cellEdge,'w'),[]);
subplot(1,3,2)
	imshow(imoverlay(yelStartImage,cellEdge,'w'),[]);	
subplot(1,3,3)
	imshow(imoverlay(yelEndImage,cellEdge,'w'),[]);	


end

