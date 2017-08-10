function [ imageStruct ] = findRedMaskChange( imageStruct )
%UNTITLED23 Summary of this function goes here
%   Detailed explanation goes here

imageDim = 432;

redN = 2;

redImage = zeros(imageDim,imageDim,redN,'double');
cellMask = zeros(imageDim,imageDim,redN,'double');

for i=1:redN
	redImage(:,:,i) = im2double(imread(imageStruct.redPath{i}));
	cellMask(:,:,i) = findCellMask(redImage(:,:,i));
end

test = cellMask(:,:,1) == cellMask(:,:,end);

imageStruct.redMaskChange = 100 - (sum(test(:))/length(test(:)))*100;

end

