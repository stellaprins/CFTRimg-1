function [ imageStruct ] = distanceMap( imageStruct,boundingBox_idx)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

image = imread(imageStruct.redPath);
boundingBox = imageStruct.boundingBox(boundingBox_idx,:);

cropped = boundingBoxToCroppedImage(image,boundingBox);

bw = cellBinarize(cropped);

pixelCount = sum(bw(:));

bwoutline = bwperim(dilated);
cropped(bwoutline) = 255;

imshow(cropped,[]) , title(sprintf('Pixel count is %d',pixelCount))


end

