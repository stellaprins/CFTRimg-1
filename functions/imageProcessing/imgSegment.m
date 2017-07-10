function [ bw ] = imgSegment( image )
%IMGSEGMENT Summary of this function goes here
%   Detailed explanation goes here

gray = mat2gray(image,[min(image(:)) max(image(:))]);

adjusted = imadjust(gray,[],[],0.7);

bw = imbinarize(adjusted);

filled = imfill(bw);

end

