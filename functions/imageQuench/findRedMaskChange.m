function [ imageStruct ] = findRedMaskChange( imageStruct )
%FIND_RED_MASK_CHANGE Calculate difference between red images at start and
%finish
%   The results is saved to the imageQuench struct under attribute
%   'redMaskChange'.

dummyImage = imread(imageStruct.redPath{1});
imageDimM = size(dummyImage,1);
imageDimN = size(dummyImage,2);

redN = 2;

redImage = zeros(imageDimM,imageDimN,redN,'double');
cellMask = zeros(imageDimM,imageDimN,redN,'double');

for i=1:redN
	redImage(:,:,i) = im2double(imread(imageStruct.redPath{i}));
	cellMask(:,:,i) = findCellMask(redImage(:,:,i));
end

test = cellMask(:,:,1) == cellMask(:,:,end);

imageStruct.redMaskChange = 100 - (sum(test(:))/length(test(:)))*100;

end

