function [ imageStruct ] = distanceMap( imageStruct )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

redImage = im2double(imread(imageStruct.redPath));
yelImage = im2double(imread(imageStruct.yelPath));

cellN = imageStruct.cellN(end);
% redBackground = imageStruct.redBackground;
% yelBackground = imageStruct.yelBackground;

yelMeanEntire		= zeros(cellN,1);
yelMeanOutside	= zeros(cellN,1);
yelMeanMembrane	= zeros(cellN,1);
yelMeanInterior	= zeros(cellN,1);

redMeanEntire		= zeros(cellN,1);
redMeanOutside	= zeros(cellN,1);
redMeanMembrane	= zeros(cellN,1);
redMeanInterior = zeros(cellN,1);

for i=1:cellN
	
	boundingBox = imageStruct.boundingBox(i,:);
	
	cellMask = boundingBoxToCellMask(redImage,boundingBox);
	
	distanceMap = makeDistanceMap(cellMask);
	
	redCropped = boundingBoxToCroppedImage(redImage,boundingBox);
	yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox);
	
	%%%%%%%
	membraneMask = distanceMap >= 0 & distanceMap < 10*BINNING;
	
	yelMeanEntire(i) = sum(cellMask .* yelCropped) / sum(cellMask);
	yelMeanOutside(i) = sum(~cellMask .* yelCropped) / sum(~cellMask);
	yelMeanMembrane(i) = sum(membraneMask .* yelCropped) / sum(membraneMask);
	yelMeanInterior(i) = sum((cellMask & ~membraneMask) .* yelCropped) ...
		/ sum(cellMask & ~membraneMask);
	
	redMeanEntire(i) = sum(cellMask .* redCropped) / sum(cellMask);
	redMeanOutside(i) = sum(~cellMask .* redCropped) / sum(~cellMask);
	redMeanMembrane(i) = sum(membraneMask .* redCropped) / sum(membraneMask);
	redMeanInterior(i) = sum((cellMask & ~membraneMask) .* redCropped) ...
		/ sum(cellMask & ~membraneMask);
	%%%%%%%
	
 	if i==2
		showDistanceMapProcess(...
			redCropped,yelCropped,cellMask,distanceMap,membraneMask);
	end

end

imageStruct.yelEntire				= yelMeanEntire;
imageStruct.yelOutside			= yelMeanOutside;
imageStruct.yelMembrane			= yelMeanMembrane;
imageStruct.yelInterior = yelMeanInterior;

imageStruct.redEntire				= redMeanEntire;
imageStruct.redOutside			= redMeanOutside;
imageStruct.redMembrane			= redMeanMembrane;
imageStruct.redInterior     = redMeanInterior;

end

