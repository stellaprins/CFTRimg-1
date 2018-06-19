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

yelMeanEntire		= zeros(cellN,1);
yelMeanOutside	= zeros(cellN,1);
yelMeanMembrane	= zeros(cellN,1);
yelMeanInterior	= zeros(cellN,1);
redMeanEntire		= zeros(cellN,1);
redMeanOutside	= zeros(cellN,1);
yelEntireAbsolute = zeros(cellN,1);
yelMembraneAbsolute = zeros(cellN,1);
redEntireAbsolute = zeros(cellN,1);

for i=1:cellN
	
	boundingBox = imageStruct.boundingBox(i,:);
	cellMask		= boundingBoxToCellMask(redImage,boundingBox,binning);
	distanceMap = cellMaskToDistanceMap(cellMask);
	
	redCropped = boundingBoxToCroppedImage(redImage,boundingBox,binning);
	yelCropped = boundingBoxToCroppedImage(yelImage,boundingBox,binning);
	redCropAdj = redCropped - redBackground;
	yelCropAdj = yelCropped - yelBackground;
	
	%%%%%%%
	membraneMask = distanceMap >= 0 & distanceMap < 10*binning;
	yelEntireAbsolute(i)		= sum(sum(cellMask .* yelCropAdj)) ;
	yelMembraneAbsolute(i)	= sum(sum(membraneMask .* yelCropAdj)); 
	redEntireAbsolute(i)		= sum(sum(cellMask .* redCropAdj)) ;
	yelMeanEntire(i)				= sum(cellMask .* yelCropAdj) / sum(cellMask);
	yelMeanOutside(i)				= sum(~cellMask .* yelCropAdj) / sum(~cellMask);
	yelMeanMembrane(i)			= sum(membraneMask .* yelCropAdj) / sum(membraneMask);
	yelMeanInterior(i)			= sum((cellMask & ~membraneMask) .* yelCropAdj) ...
														/ sum(cellMask & ~membraneMask);
	redMeanEntire(i)				= sum(cellMask .* redCropAdj) / sum(cellMask);
	redMeanOutside(i)				= sum(~cellMask .* redCropped) / sum(~cellMask);
	%%%%%%%

end
imageStruct.yelEntire				= yelMeanEntire;
imageStruct.yelOutside			= yelMeanOutside;
imageStruct.yelMembrane			= yelMeanMembrane;
imageStruct.yelInterior			= yelMeanInterior;
imageStruct.redEntire				= redMeanEntire;
imageStruct.redOutside			= redMeanOutside;
imageStruct.yelEntireAbsolute		= yelEntireAbsolute;
imageStruct.yelMembraneAbsolute	= yelMembraneAbsolute;
imageStruct.redEntireAbsolute		= redEntireAbsolute;

end

