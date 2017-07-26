function [ binaryImage ] = cellBinarize( croppedImage )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

thresh = 0.9*graythresh(croppedImage);

bw = imbinarize(croppedImage, thresh);

seErode = strel('disk',floor(5*BINNING));
seDilate = strel('disk',floor(8*BINNING));
eroded = imerode(bw,seErode);
filled = imfill(eroded,'holes');
binaryImage = imdilate(filled,seDilate);

end

