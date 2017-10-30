function [ binaryImage ] = cellBinarize( croppedImage )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

adjusted = croppedImage; % imadjust(croppedImage);

thresh = 0.75*graythresh(adjusted);

bw = imbinarize(adjusted,thresh);

seOpen = strel('disk',floor(4*BINNING));
opened = imopen(bw,seOpen);

filled = imfill(opened,'holes');
cleared = bwareaopen(filled,2400*BINNING);

seClose = strel('disk',floor(4*BINNING));
closed = imclose(cleared,seClose);

seUnit = strel('disk',1);
eroded = closed;
for i=1:6*BINNING
	eroded = imerode(eroded,seUnit);
end

dilated = eroded;
for i=1:floor(8*BINNING)
	dilated = imdilate(dilated,seUnit);
end

% smoothed = imbinarize(imgaussfilt(im2double(dilated),5),0.8);

binaryImage = dilated;
	

end

