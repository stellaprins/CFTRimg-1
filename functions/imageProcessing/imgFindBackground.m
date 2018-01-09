function [ imageStruct ] = imgFindBackground( imageStruct )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

yelImage = imread(imageStruct.yelPath);
redImage = imread(imageStruct.redPath);

dYelImage = im2double(yelImage);
dRedImage = im2double(redImage);

yelQuant = quantile(dYelImage(:),3);
redQuant = quantile(dRedImage(:),3);

yelThresh = yelQuant(1);
redThresh = redQuant(1);

yelMask = dYelImage > yelThresh;
redMask = dRedImage > redThresh;

combinedMask = redMask & yelMask;

seDilate = strel('disk',5);
dilatedMask = imdilate(combinedMask,seDilate);

backgroundMask = ~dilatedMask;

yelMeanBackground = sum(dYelImage(:) .* backgroundMask(:)) / sum(backgroundMask(:));
redMeanBackground = sum(dRedImage(:) .* backgroundMask(:)) / sum(backgroundMask(:));

imageStruct.yelBackground = yelMeanBackground;
imageStruct.redBackground = redMeanBackground;


end

