function [ binaryImage ] = cellBinarize( croppedImage )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

adjusted = imadjust(croppedImage);

thresh = 0.9*graythresh(adjusted);

bw = imbinarize(adjusted,thresh);

seOpen = strel('disk',floor(6*BINNING));
opened = imopen(bw,seOpen);

filled = imfill(opened,'holes');
cleared = bwareaopen(filled,2400*BINNING);

seDilate = strel('square',floor(6*BINNING));
binaryImage = imdilate(cleared,seDilate);

end

