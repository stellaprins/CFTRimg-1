function [ imageStruct ] = findYelInsideOverTime( imageStruct )
%UNTITLED24 Summary of this function goes here
%   Detailed explanation goes here

imageDim = 432;

redN = 2;
yelN = 70;
redImage = zeros(imageDim,imageDim,redN,'double');
cellMask = zeros(imageDim,imageDim,redN,'double');
yelImage = zeros(imageDim,imageDim,yelN,'double');

yelInside = zeros(yelN,1);
yelOutside = zeros(yelN,1);

for i=1:redN
	redImage(:,:,i) = im2double(imread(imageStruct.redPath{i}));
	cellMask(:,:,i) = findCellMask(redImage(:,:,i));
end

for i=1:yelN
	yelImage(:,:,i) = im2double(imread(imageStruct.yelPath{i}));
% 	yelImage(:,:,i) = (yelImage(:,:,i) - imageStruct.yelBackground) ...
% 		/ imageStruct.redExpression;
end

minF = min(yelImage(:));
maxF = max(yelImage(:));

for i=1:yelN
	yelImage(:,:,i) = imadjust(yelImage(:,:,i),[minF;maxF],[0;1]);
	tmpIn = yelImage(:,:,i) .* cellMask(:,:,1);
	tmpOut = yelImage(:,:,i) .* imcomplement(cellMask(:,:,1));
	yelInside(i) = mean(tmpIn(:));
	yelOutside(i) = mean(tmpOut(:));
end

minF = min(yelImage(:));
maxF = max(yelImage(:));

imageStruct.yelInsideOverT = yelInside;

% figure
% showQuenchImage(redImage(:,:,1),yelImage(:,:,1),cellMask(:,:,1))

end

