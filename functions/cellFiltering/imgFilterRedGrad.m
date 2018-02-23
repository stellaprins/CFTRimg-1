function [ imageStruct ] = imgFilterRedGrad( imageStruct )
%imgFilterRedGrad Filters cells with low max change in mCherry fluorescence
%over distance.
	%  We say that the segmentation of a particular cell has been performed
	%  well if the cell mask closely matches the mCHerry fluorescence. This
	%  means that if we plot the mCherry fluorescence as a function of the
	%  distance from the cell border, the should be a steep increase in the
	%  mCherry fluorescence at the cell membrane.
	%
	%  This function filters all cells whose max gradient of mCherry
	%  fluorescence over distance is below a reference value. This has been
	%  arbitrarily set at changing from maximum to minimum in 40 pixels.

global BINNING

% import image
image = im2double(imread(imageStruct.redPath));

% initialise comparison vector (to see if cell meets conditions)
cellLogical = zeros(imageStruct.cellN(end),1);

% find max change in mCherry fluorescence (over distance from cell border)
[ maxGradient , ~ ] = findGradient( imageStruct );

for idx=1:imageStruct.cellN(end)
	
	boundingBox = imageStruct.boundingBox(idx,:);
	redCropped = boundingBoxToCroppedImage(image,boundingBox);
	
	% define max and min red fluorescences for each cell
	redMin = min(redCropped(:));
	redMax = max(redCropped(:));
	
	% define a reference gradient based on cell being approx 150 pixels wide
	refGradient = (redMax - redMin) / (75*BINNING);
	
	% test if cell's max gradient is higher than reference
	cellLogical(idx) = maxGradient(idx) > refGradient;

end

% count number of cells matching the condition and initialise new BB
cellN = sum(cellLogical);
newBoundingBox = zeros(cellN,4);

% replace old bounding boxes with new ones
counter = 1;
for idx=1:imageStruct.cellN(end)
	boundingBox = imageStruct.boundingBox(idx,:);
	if cellLogical(idx) == 1
		newBoundingBox(counter,:)	= boundingBox;
		counter = counter + 1;
	end
end

imageStruct.boundingBox = newBoundingBox;
imageStruct.cellN(1,end+1) = counter - 1;


end
	

