function [ imageStruct ] = findYelInsideOverTime( imageStruct )
%FIND_YEL_INSIDE_OVER_TIME Collect yellow fluorescence intensity data from
%each quench image giving time series data.
%   1. The red images from the start and finish are binarized to locate
%   cells. The binarized cell masks are combined to give a larger cell
%   area, accounting for the slight movement of cells over the time course
%   due to fluid additions.
%		2. Yellow intesity data are normalized.
%			* Normalized by the red intensity data.
%			* Normalized by the point just before the first fluid addition.


imageDim			= 432; % for 20x objective, 5x binning
yelN					= length(imageStruct.yelPath);
redImageStart	= im2double(imread(imageStruct.redPath{1})); 
redImageEnd		= im2double(imread(imageStruct.redPath{2}));
cellMaskStart = findCellMask(redImageStart);
cellMaskEnd		= findCellMask(redImageEnd);
cellMask			= cellMaskStart | cellMaskEnd;
tmpRedInside	= redImageEnd .* cellMask;
tmpRedOutside = redImageEnd .* ~cellMask;
redInside			= sum(tmpRedInside(:)) / sum(cellMask(:));
redOutside		= sum(tmpRedOutside(:)) / sum(~cellMask(:));
redSignal			= redInside - redOutside;
yelImage			= zeros(imageDim,imageDim,yelN,'double');
yelInside			= zeros(yelN,1);
yelOutside		= zeros(yelN,1);

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

% showQuenchImage( imageStruct )

end

