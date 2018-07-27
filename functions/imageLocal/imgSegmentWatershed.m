function [ imageStruct ] = imgSegmentWatershed( imageStruct )
%IMG_SEGMENT_WATERSHED Segment localization images to locate cells
%   The watershed method is used to perform this segmentation.

mode = 'full'; % 'full' OR 'test';

binning		= imageStruct.binning;

I					= im2double(imread(imageStruct.redPath));
Ieq				= adapthisteq(I,'NumTiles',[20 20]);
Ibw				= imbinarize(Ieq,'adaptive');
closeSE		= strel('disk',4*binning);
Iclosed		= imclose(Ibw,closeSE);
Icleared	= bwareaopen(Iclosed,ceil(4800*binning));
Ifilled		= imfill(Icleared,'holes');
dilateSE	= strel('disk',ceil(4*binning));
Idilated	= imopen(Ifilled,dilateSE);
smallEM		= imextendedmax(I, 0.9*median(I(:)));
smallEM		= imclose(smallEM, closeSE);
smallEM		= bwareaopen(smallEM, 120*binning);
smallEM		= imerode(smallEM, ones(6*binning));
largeEM		= imextendedmax(I, median(I(:)));
largeEM		= imclose(largeEM, closeSE);
largeEM		= imfill(largeEM, 'holes');
largeEM		= bwareaopen(largeEM, 1200*binning);
BGmarkers = largeEM | Idilated;

if strcmp(mode,'test')
	IbwPerim	= bwperim(BGmarkers);
	overlay		= imoverlay(Ieq, IbwPerim|smallEM, [.3 1 .3]);
end

complement	= imcomplement(I);
Imod				= imimposemin(complement, ~BGmarkers | smallEM);
L						= watershed(Imod);

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

