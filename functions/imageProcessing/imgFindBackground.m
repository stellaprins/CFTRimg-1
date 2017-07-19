function [ imageStruct ] = imgFindBackground( imageStruct )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

image = imread(imageStruct.yelPath);

dImage = im2double(image);

thresh = 0.5*graythresh(dImage);

backgroundMask = dImage < thresh;

meanBackground = sum(dImage(:) .* backgroundMask(:)) / sum(backgroundMask(:));

imageStruct.yelBackground = meanBackground;


end

