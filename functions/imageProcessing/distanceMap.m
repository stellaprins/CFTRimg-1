function [ imageStruct ] = distanceMap( imageStruct )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

redImage = imread(imageStruct.redPath);
yelImage = imread(imageStruct.yelPath);

cellN = imageStruct.cellN(end);
redBackground = imageStruct.redBackground;
yelBackground = imageStruct.yelBackground;

yelMeanInsideCell		= zeros(cellN,1);
yelMeanOutsideCell		= zeros(cellN,1);
yelMeanMembrane			= zeros(cellN,1);
yelRatioOutsideInside	= zeros(cellN,1);
yelRatioMembraneInside	= zeros(cellN,1);
redMeanInsideCell		= zeros(cellN,1);
redMeanOutsideCell		= zeros(cellN,1);
redMeanMembrane			= zeros(cellN,1);
redRatioOutsideInside	= zeros(cellN,1);
redRatioMembraneInside	= zeros(cellN,1);

for i=1:cellN
	
	boundingBox = imageStruct.boundingBox(i,:);

	redCropped = boundingBoxToCroppedImage(redImage,boundingBox);
	yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox);
	
	redCropAdj = im2double(redCropped) - redBackground;
	yelCropAdj = im2double(yelCropped) - yelBackground;
	
	cellMask = cellBinarize(redCropAdj);
	
	distanceMap = makeDistanceMap(cellMask);
	
	%%%%%%%
	membraneMask = distanceMap >= 0 & distanceMap < 10*BINNING;
	
	yelMeanInsideCell(i) = sum(cellMask .* yelCropAdj) / sum(cellMask);
	yelMeanOutsideCell(i) = sum(~cellMask .* yelCropAdj) / sum(~cellMask);
	yelMeanMembrane(i) = sum(membraneMask .* yelCropAdj) / sum(membraneMask);
	
	yelRatioOutsideInside(i) = yelMeanOutsideCell(i) / yelMeanInsideCell(i);
	yelRatioMembraneInside(i) = yelMeanMembrane(i) / yelMeanInsideCell(i);
	
	redMeanInsideCell(i) = sum(cellMask .* redCropAdj) / sum(cellMask);
	redMeanOutsideCell(i) = sum(~cellMask .* redCropAdj) / sum(~cellMask);
	redMeanMembrane(i) = sum(membraneMask .* redCropAdj) / sum(membraneMask);
	
	redRatioOutsideInside(i) = redMeanOutsideCell(i) / redMeanInsideCell(i);
	redRatioMembraneInside(i) = redMeanMembrane(i) / redMeanInsideCell(i);
	%%%%%%%
	
%  	if i==1
% 		showDistanceMapProcess(...
% 			redCropped,yelCropped,cellMask,distanceMap,membraneMask);
% 	end

end

imageStruct.yelInsideCell = yelMeanInsideCell;
imageStruct.yelOutsideCell = yelMeanOutsideCell;
imageStruct.yelMembrane = yelMeanMembrane;
imageStruct.yelRatioOutIn = yelRatioOutsideInside;
imageStruct.yelRatioMembraneIn = yelRatioMembraneInside;

imageStruct.redInsideCell = redMeanInsideCell;
imageStruct.redOutsideCell = redMeanOutsideCell;
imageStruct.redMembrane = redMeanMembrane;
imageStruct.redRatioOutIn = redRatioOutsideInside;
imageStruct.redRatioMembraneIn = redRatioMembraneInside;

end

