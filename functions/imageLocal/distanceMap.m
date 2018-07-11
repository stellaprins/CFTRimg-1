function [ imageStruct ] = distanceMap( imageStruct )
%DISTANCE_MAP Calculate mean intensity values in different cell regions
%using a map of distance from cell border
%		For each cell, the distance from the cell border is calculated in
%		pixels, with the cell border being defined by the binarized cell mask.
%
%		The membrane is defined as any (unbinned) pixel within 10 of the
%		border. All values are adjusted by the background intensity for the
%		full image.
%
%		The membrane density metric 'memDens' is also calculated and its
%		log-transformed value 'logMemDens'. The log-transformation is
%		calculated so that the data approximates a normal distribution.

redImage = im2double(imread(imageStruct.redPath));
yelImage = im2double(imread(imageStruct.yelPath));

binning = imageStruct.binning;

cellN					= imageStruct.cellN(end);
redBackground = imageStruct.redBackground;
yelBackground = imageStruct.yelBackground;

yelEntireMean		= zeros(cellN,1);
yelOutsideMean	= zeros(cellN,1);
yelMembraneMean	= zeros(cellN,1);
yelInteriorMean	= zeros(cellN,1);
redEntireMean		= zeros(cellN,1);
redOutsideMean	= zeros(cellN,1);
yelEntireAbsolute = zeros(cellN,1);
yelMembraneAbsolute = zeros(cellN,1);
redEntireAbsolute = zeros(cellN,1);

for i=1:cellN
	
	boundingBox		= imageStruct.boundingBox(i,:);
	cellMask			= boundingBoxToCellMask(redImage,boundingBox,binning);
	distanceMap		= cellMaskToDistanceMap(cellMask);
	membraneMask	= distanceMap >= 0 & distanceMap < 10*binning;
	interiorMask	= cellMask & ~membraneMask;
	outsideMask		= ~cellMask;
	
	redCropped = boundingBoxToCroppedImage(redImage,boundingBox,binning);
	yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox,binning);
	redCropAdj = redCropped - redBackground;
	yelCropAdj = yelCropped - yelBackground;
	
	%%%%%%%
	redEntire			= cellMask .* redCropAdj;
	redOutside		= outsideMask .* redCropAdj;
	yelMembrane		= membraneMask .* yelCropAdj;
	yelEntire			= cellMask .* yelCropAdj;
	yelOutside		= outsideMask .* yelCropAdj;
	yelInterior		= interiorMask .* yelCropAdj;
	
	entirePixelCount		= sum(cellMask(:));
	membranePixelCount	= sum(membraneMask(:));
	outsidePixelCount		= sum(outsideMask(:));
	interiorPixelCount	= sum(interiorMask(:));
	
	yelEntireAbsolute(i)		= sum(yelEntire(:));
	yelMembraneAbsolute(i)	= sum(yelMembrane(:)); 
	redEntireAbsolute(i)		= sum(redEntire(:)) ;
	yelEntireMean(i)				= yelEntireAbsolute(i) / entirePixelCount;
	yelOutsideMean(i)				= sum(yelOutside(:)) / outsidePixelCount;
	yelMembraneMean(i)			= yelMembraneAbsolute(i) / membranePixelCount;
	yelInteriorMean(i)			= sum(yelInterior(:)) / interiorPixelCount;
	redEntireMean(i)				= redEntireAbsolute(i) / entirePixelCount;
	redOutsideMean(i)				= sum(redOutside(:)) / outsidePixelCount;
	%%%%%%%

end
imageStruct.yelEntire				= yelEntireMean;
imageStruct.yelOutside			= yelOutsideMean;
imageStruct.yelMembrane			= yelMembraneMean;
imageStruct.yelInterior			= yelInteriorMean;
imageStruct.redEntire				= redEntireMean;
imageStruct.redOutside			= redOutsideMean;
imageStruct.yelEntireAbsolute		= yelEntireAbsolute;
imageStruct.yelMembraneAbsolute	= yelMembraneAbsolute;
imageStruct.redEntireAbsolute		= redEntireAbsolute;

end

