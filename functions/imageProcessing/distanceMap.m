function [ imageStruct ] = distanceMap( imageStruct )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

redImage = imread(imageStruct.redPath);
yelImage = imread(imageStruct.yelPath);

cellN = imageStruct.cellN(end);
background = imageStruct.yelBackground;

meanInsideCell		= zeros(cellN,1);
meanOutsideCell		= zeros(cellN,1);
meanMembrane		= zeros(cellN,1);
ratioOutsideInside	= zeros(cellN,1);
ratioMembraneInside = zeros(cellN,1);

for i=1:cellN
	
	boundingBox = imageStruct.boundingBox(i,:);

	redCropped = boundingBoxToCroppedImage(redImage,boundingBox);
	yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox);
	yelCropAdj = im2double(yelCropped) - background;
	
	cellMask = cellBinarize(redCropped);
	
	distanceMap = makeDistanceMap(cellMask);
	
	%%%%%%%
	membraneMask = distanceMap >= 0 & distanceMap < 10*BINNING;
	
	meanInsideCell(i) = sum(cellMask .* yelCropAdj) / sum(cellMask);
	meanOutsideCell(i) = sum(~cellMask .* yelCropAdj) / sum(~cellMask);
	meanMembrane(i) = sum(membraneMask .* yelCropAdj) / sum(membraneMask);
	
	ratioOutsideInside(i) = meanOutsideCell(i) / meanInsideCell(i);
	ratioMembraneInside(i) = meanMembrane(i) / meanInsideCell(i);
	%%%%%%%
	
	% 	if i==1
% 		showDistanceMapProcess(...
% 			redCropped,yelCropped,BW,positiveDistanceMap,membraneBW);
% 	end

end

imageStruct.meanInsideCell = meanInsideCell;
imageStruct.meanOutsideCell = meanOutsideCell;
imageStruct.meanMembrane = meanMembrane;

imageStruct.ratioOutsideInside = ratioOutsideInside;
imageStruct.ratioMembraneInside = ratioMembraneInside;

end

