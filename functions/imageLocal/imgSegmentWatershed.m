function [ imageStruct ] = imgSegmentWatershed( imageStruct )
%IMG_SEGMENT_WATERSHED Segment localization images to locate cells
%   The watershed method is used to perform this segmentation.

mode = 'full'; % 'full' OR 'test';

global BINNING

I					= im2double(imread(imageStruct.redPath));
Ieq				= adapthisteq(I,'NumTiles',[20 20]);
Ibw				= imbinarize(Ieq,'adaptive');
closeSE		= strel('disk',4*BINNING);
Iclosed		= imclose(Ibw,closeSE);
Icleared	= bwareaopen(Iclosed,ceil(4800*BINNING));
Ifilled		= imfill(Icleared,'holes');
dilateSE	= strel('disk',ceil(4*BINNING));
Idilated	= imopen(Ifilled,dilateSE);
smallEM = imextendedmax(I, 0.9*median(I(:)));
smallEM = imclose(smallEM, closeSE);
smallEM = bwareaopen(smallEM, 120);
smallEM = imerode(smallEM, ones(6*BINNING));
largeEM = imextendedmax(I, median(I(:)));
largeEM = imclose(largeEM, closeSE);
largeEM = imfill(largeEM, 'holes');
largeEM = bwareaopen(largeEM, 1200);
BGmarkers = largeEM | Idilated;

if strcmp(mode,'test')
	IbwPerim = bwperim(BGmarkers);
	overlay = imoverlay(Ieq, IbwPerim|smallEM, [.3 1 .3]);
end

complement	= imcomplement(I);
Imod				= imimposemin(complement, ~BGmarkers | smallEM);
L						= watershed(Imod);


if strcmp(mode,'test')
 	showWatershedProcess(imageStruct,Ibw,BGmarkers,smallEM,overlay,label2rgb(L))
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

