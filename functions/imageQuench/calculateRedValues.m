function [ imageStruct ] = calculateRedValues( imageStruct )
%UNTITLED25 Summary of this function goes here
%   Detailed explanation goes here


redImage = im2double(imread(imageStruct.redPath{1}));

cellMask = findCellMask(redImage);
backgroundMask = ~cellMask;

imageStruct.redForeground = sum(redImage(:) .* cellMask(:)) / ...
																sum(cellMask(:));
imageStruct.redBackground = sum(redImage(:) .* backgroundMask(:)) / ...
																sum(backgroundMask(:));


end

