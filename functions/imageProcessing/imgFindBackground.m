function [ imageStruct ] = imgFindBackground( imageStruct )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

yelImage = imread(imageStruct.yelPath);
redImage = imread(imageStruct.redPath);

dYelImage = im2double(yelImage);
dRedImage = im2double(redImage);

yelThresh = 0.5*graythresh(dYelImage);
redThresh = 0.5*graythresh(dRedImage);

yelBackgroundMask = dYelImage < yelThresh;
redBackgroundMask = dRedImage < redThresh;

yelMeanBackground = sum(dYelImage(:) .* yelBackgroundMask(:)) / sum(yelBackgroundMask(:));
redMeanBackground = sum(dRedImage(:) .* redBackgroundMask(:)) / sum(redBackgroundMask(:));

imageStruct.yelBackground = yelMeanBackground;
imageStruct.redBackground = redMeanBackground;


end

