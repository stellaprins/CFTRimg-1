function [ binaryImage ] = cellBinarize( croppedImage )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

adjusted = croppedImage; % imadjust(croppedImage);

thresh = 0.9*graythresh(adjusted);

bw = imbinarize(adjusted,thresh);

seOpen = strel('disk',floor(6*BINNING));
opened = imopen(bw,seOpen);

filled = imfill(opened,'holes');
cleared = bwareaopen(filled,2400*BINNING);

seDilate = strel('disk',floor(6*BINNING));
closed = imclose(cleared,seDilate);

seUnit = strel('disk',1);
eroded = closed;
for i=1:6*BINNING
	eroded = imerode(eroded,seUnit);
end

dilated = eroded;
for i=1:18*BINNING
	dilated = imdilate(closed,seUnit);
end

binaryImage = dilated;
	

end

