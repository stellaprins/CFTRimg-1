function [ imageStruct ] = findYelInsideOverTime( imageStruct )
%UNTITLED24 Summary of this function goes here
%   Detailed explanation goes here

imageDim    = 432;
yelN        = 70;
redImage    = im2double(imread(imageStruct.redPath{1}));
cellMask    = findCellMask(redImage);
tmpRedIn    = redImage .* cellMask;
tmpRedOut   = redImage .* ~cellMask;
redInside   = sum(tmpRedIn(:)) / sum(cellMask(:));
redOutside  = sum(tmpRedOut(:)) / sum(~cellMask(:));
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
yelData		= yelSignal / redSignal;
yelStandard = yelData(4);
imageStruct.yelInsideOverT  = yelData / yelStandard;


% yelInside   = imageStruct.yelInsideOverT;
% concIodine  = 1.9 * ((1-yelInside)./yelInside); % mM
% gradIodine  = zeros(69,1);
% 
%     for i=1:length(gradIodine)
%       gradIodine(i) = (concIodine(i+1) - concIodine(i)) / 2; % mM s^(-1)
%     end

% imageStruct.gradIodine      = gradIodine;

% if strcmp(runmode,'test')
% 	showQuenchImage(imageStruct)
% end
	
end

