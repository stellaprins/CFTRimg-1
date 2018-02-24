function [ binaryImage ] = cellBinarize( croppedImage )
%CELL_BINARIZE Create cell mask from cropped image
%   Binarized cell mask is created from a cropped image. A series of
%   morphological functions are performed to smooth the cell edges, and
%   ensure there is a single connected binarized area.

global BINNING

thresh = 0.9*graythresh(croppedImage);

bw = imbinarize(croppedImage,thresh);

seOpen = strel('disk',floor(6*BINNING));
opened = imopen(bw,seOpen);

filled = imfill(opened,'holes');
cleared = bwareaopen(filled,floor(2400*BINNING));

seDilate = strel('disk',floor(6*BINNING));
closed = imclose(cleared,seDilate);

seUnit = strel('disk',1);
eroded = closed;
for i=1:floor(6*BINNING)
	eroded = imerode(eroded,seUnit);
end

dilated = eroded;
for i=1:floor(18*BINNING)
	dilated = imdilate(closed,seUnit);
end

binaryImage = dilated;
	

end

