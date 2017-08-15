function [ imageStruct ] = imgFindBackground( imageStruct )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

yelImage = im2double(imread(imageStruct.yelPath));

redImage = im2double(imread(imageStruct.redPath));
redQuant = quantile(redImage(:),3);
redThresh = (redQuant(1) + min(redImage)) / 2;

redMask = redImage > redThresh;

se = strel('disk',floor(4*BINNING));
openedMask = imopen(redMask,se);
closedMask = imclose(openedMask,se);
filledMask = imfill(~closedMask,'holes');

erodedMask = filledMask;
seUnit = strel('disk',1);
for i = 1:(4*BINNING)
	erodedMask = imerode(erodedMask,seUnit);
end
dilatedMask = erodedMask;
for i = 1:(4*BINNING)
	dilatedMask = imdilate(dilatedMask,seUnit);
end

backgroundMask = dilatedMask;

yelMeanBackground = sum(yelImage(:) .* backgroundMask(:)) / sum(backgroundMask(:));
redMeanBackground = sum(redImage(:) .* backgroundMask(:)) / sum(backgroundMask(:));

imageStruct.yelBackground = yelMeanBackground;
imageStruct.redBackground = redMeanBackground;


end

