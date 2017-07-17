function [ binaryImage ] = cellBinarize( croppedImage )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

bw = imbinarize(croppedImage);

seErode = strel('disk',floor(4*BINNING));
% cleared = imclearborder(eroded,8);
seDilate = strel('disk',floor(4*BINNING));
eroded = imerode(bw,seErode);

binaryImage = imdilate(eroded,seDilate);

end

