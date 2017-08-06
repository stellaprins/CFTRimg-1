function [ imageStruct ] = findYelBackground( imageStruct )
%UNTITLED22 Summary of this function goes here
%   Detailed explanation goes here

redImage = im2double(imread(imageStruct.redPath{1}));
yelImage = im2double(imread(imageStruct.yelPath{70}));

backgroundMask = findBackgroundMask(redImage);

tmp = yelImage .* backgroundMask;

imageStruct.yelBackground = mean(tmp(:));

end

