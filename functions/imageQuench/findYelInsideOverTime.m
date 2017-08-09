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
end

mask = cellMask(:,:,1);
for i=1:yelN
	tmpIn = yelImage(:,:,i) .* mask;
	tmpOut = yelImage(:,:,i) .* ~mask;
	yelInside(i) = sum(tmpIn(:)) / sum(mask(:));
	yelOutside(i) = sum(tmpOut(:)) / sum(~mask(:));
end

yelSignal = yelInside - yelOutside;
yelStandard = yelSignal(4);

imageStruct.yelInsideOverT = yelSignal / yelStandard;

% figure
% showQuenchImage(redImage(:,:,1),yelImage(:,:,1),cellMask(:,:,1))

end

