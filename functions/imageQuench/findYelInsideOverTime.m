function [ imageStruct ] = findYelInsideOverTime( imageStruct )
%UNTITLED24 Summary of this function goes here
%   Detailed explanation goes here

imageDim = 432;
yelN = 70;

redImage = im2double(imread(imageStruct.redPath{1}));
cellMask = findCellMask(redImage);

tmpRedIn = redImage .* cellMask;
tmpRedOut = redImage .* ~cellMask;
redInside = sum(tmpRedIn(:)) / sum(cellMask(:));
redOutside = sum(tmpRedOut(:)) / sum(~cellMask(:));
redSignal = redInside - redOutside;

yelImage = zeros(imageDim,imageDim,yelN,'double');
yelInside = zeros(yelN,1);
yelOutside = zeros(yelN,1);

for i=1:yelN
	
	yelImage(:,:,i) = im2double(imread(imageStruct.yelPath{i}));
	tmpYelIn = yelImage(:,:,i) .* cellMask;
	tmpYelOut = yelImage(:,:,i) .* ~cellMask;
	yelInside(i) = sum(tmpYelIn(:)) / sum(cellMask(:));
	yelOutside(i) = sum(tmpYelOut(:)) / sum(~cellMask(:));
	
end

yelSignal = yelInside - yelOutside;

yelData		= yelSignal / redSignal;
yelStandard = yelData(4);

imageStruct.yelInsideOverT = yelData / yelStandard;

% figure
% showQuenchImage(redImage(:,:,1),yelImage(:,:,1),cellMask(:,:,1))

end

