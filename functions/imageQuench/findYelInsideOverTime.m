function [ imageStruct ] = findYelInsideOverTime( imageStruct )
%UNTITLED24 Summary of this function goes here
%   Detailed explanation goes here


imageDim    = 432; % for 20x objective, 5x binning
yelN        = length(imageStruct.yelPath);
redImage1   = im2double(imread(imageStruct.redPath{1})); % mCh at the start of the timelapse
redImage2   = im2double(imread(imageStruct.redPath{2})); % mCh at the end of the timelapse
cellMask1		= findCellMask(redImage1);
cellMask2		= findCellMask(redImage2);
cellMask		= im2bw(cellMask2+cellMask1);
tmpRedIn1   = redImage1 .* cellMask;
tmpRedOut1  = redImage1 .* ~cellMask;
tmpRedIn2   = redImage2 .* cellMask;
tmpRedOut2  = redImage2 .* ~cellMask;
redInside   = sum(tmpRedIn2(:)) / sum(cellMask(:));
redOutside  = sum(tmpRedOut2(:)) / sum(~cellMask(:));
redSignal   = redInside - redOutside;
yelImage    = zeros(imageDim,imageDim,yelN,'double');
yelInside   = zeros(yelN,1);
yelOutside  = zeros(yelN,1);

for i=1:yelN
	yelImage(:,:,i) = im2double(imread(imageStruct.yelPath{i}));
	tmpYelIn        = yelImage(:,:,i) .* cellMask;
	tmpYelOut       = yelImage(:,:,i) .* ~cellMask;
	yelInside(i)    = sum(tmpYelIn(:)) / sum(cellMask(:));
	yelOutside(i)   = sum(tmpYelOut(:)) / sum(~cellMask(:));
end

yelSignal   = yelInside - yelOutside;
yelData			= yelSignal / redSignal;
yelStandard = yelData(5);
imageStruct.yelInsideOverT  = yelData / yelStandard;
% figure
% showQuenchImage(redImage(:,:,1),yelImage(:,:,1),cellMask(:,:,1))

end

