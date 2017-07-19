function [ imageStruct ] = distanceMap( imageStruct )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

redImage = imread(imageStruct.redPath);
yelImage = imread(imageStruct.yelPath);
cellN = imageStruct.cellN(end);

meanInsideCell = zeros(cellN,1);
meanOutsideCell = zeros(cellN,1);
meanMembrane = zeros(cellN,1);

for i=1:cellN
	
	boundingBox = imageStruct.boundingBox(i,:);

	redCropped = boundingBoxToCroppedImage(redImage,boundingBox);
	yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox);
	yelCropped = im2double(yelCropped);

	BW = cellBinarize(redCropped);
	
	positiveDistanceMap = ceil(bwdist(~BW));
	
	membraneBW = positiveDistanceMap > 0 & positiveDistanceMap <= 10*BINNING;
	
% 	if i==1
% 		showDistanceMapProcess(...
% 			redCropped,yelCropped,BW,positiveDistanceMap,membraneBW);
% 	end
	
	meanInsideCell(i) = sum(BW .* yelCropped) / sum(BW);
	meanOutsideCell(i) = sum(~BW .* yelCropped) / sum(~BW);
	meanMembrane(i) = sum(membraneBW .* yelCropped) / sum(membraneBW);
	
end

imageStruct.meanInsideCell = meanInsideCell;
imageStruct.meanOutsideCell = meanOutsideCell;
imageStruct.meanMembrane = meanMembrane;


end

