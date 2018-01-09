function [ imageStruct ] = findRedExpression( imageStruct )
%UNTITLED25 Summary of this function goes here
%   Detailed explanation goes here


redImage = im2double(imread(imageStruct.redPath{1}));

cellMask = findCellMask(redImage);

tmp = redImage .* cellMask;

imageStruct.redExpression = mean(tmp(:));


end

