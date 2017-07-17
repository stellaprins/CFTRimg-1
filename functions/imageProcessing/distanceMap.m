function [ imageStruct ] = distanceMap( imageStruct,boundingBox_idx)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global BINNING

image = imread(imageStruct.path);
boundingBox = imageStruct.boundingBox(boundingBox_idx,:);

extra = 20*BINNING;

xmin = ceil(boundingBox(1)) - extra;
xmax = floor(boundingBox(1)) + boundingBox(3) + extra;
ymin = ceil(boundingBox(2)) - extra;
ymax = floor(boundingBox(2)) + boundingBox(4) + extra;

cropped = image(ymin:ymax,xmin:xmax);

bw = imbinarize(cropped);

seErode = strel('disk',floor(5*BINNING));
seDilate = strel('disk',floor(12*BINNING));
eroded = imerode(bw,seErode);
% cleared = imclearborder(eroded,8);
dilated = imdilate(eroded,seDilate);

pixelCount = sum(dilated(:));

bwoutline = bwperim(dilated);
cropped(bwoutline) = 255;

imshow(cropped,[]) , title(sprintf('Pixel count is %d',pixelCount))


end

