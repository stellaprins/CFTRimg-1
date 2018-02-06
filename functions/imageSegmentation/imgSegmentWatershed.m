function [ imageStruct ] = imgSegmentWatershed( imageStruct )
%IMGSEGMENTWATERSHED Summary of this function goes here
%   Detailed explanation goes here

mode = 'full'; % 'full' OR 'test';

global BINNING

I = imread(imageStruct.redPath);
dI = im2double(I);
% imshow(dI,[])
 
Ieq = adapthisteq(dI,'NumTiles',[20 20]);
% figure, imshow(Ieq,[])

Ibw = imbinarize(Ieq,'adaptive');
% figure, imshow(Ibw)

closeSE = strel('disk',4*BINNING);
Iclosed = imclose(Ibw,closeSE);
% figure, imshow(Iclosed)

Icleared = bwareaopen(Iclosed,ceil(4800*BINNING));
% figure, imshow(Icleared)

Ifilled = imfill(Icleared,'holes');
% figure, imshow(Ifilled)

dilateSE = strel('disk',ceil(4*BINNING));
Idilated = imopen(Ifilled,dilateSE);
% figure, imshow(Idilated)

smallEM = imextendedmax(dI, 0.9*median(dI(:)));
smallEM = imclose(smallEM, closeSE);
smallEM = bwareaopen(smallEM, 120);
smallEM = imerode(smallEM, ones(6*BINNING));
% figure, imshow(smallEM)

largeEM = imextendedmax(dI, median(dI(:)));
largeEM = imclose(largeEM, closeSE);
largeEM = imfill(largeEM, 'holes');
largeEM = bwareaopen(largeEM, 1200);
% figure, imshow(largeEM)

background = largeEM | Idilated;
% figure, imshow(background)

if strcmp(mode,'test')
	IbwPerim = bwperim(background);
	overlay = imoverlay(Ieq, IbwPerim|smallEM, [.3 1 .3]);
% 	figure, imshow(overlay)
end

complement = imcomplement(dI);

Imod = imimposemin(complement, ~background | smallEM);

L = watershed(Imod);
% figure, imshow(label2rgb(L))

if strcmp(mode,'test')
 	showWatershedProcess(imageStruct,Ibw,background,smallEM,overlay,label2rgb(L))
end

properties = regionprops(L,'BoundingBox','Area');

counter = 1;
for i=1:length(properties)
	
	if properties(i).Area > 100
		imageStruct.boundingBox(counter,:) = properties(i).BoundingBox;
		counter = counter + 1;
	end
	
end

imageStruct.cellN(1,1) = counter - 1;

end

