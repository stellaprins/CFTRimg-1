function [ imageStruct ] = imgSegmentWatershed( imageStruct )
%IMGSEGMENTWATERSHED Summary of this function goes here
%   Detailed explanation goes here

global BINNING

I = imread(imageStruct.redPath);
dI = im2double(I);
% imshow(dI,[])
 
% hy = fspecial('sobel');
% hx = hy';
% Iy = imfilter(dI, hy, 'replicate');
% Ix = imfilter(dI, hx, 'replicate');
% gradmag = sqrt(Ix.^2 + Iy.^2);
% figure
% imshow(gradmag,[]), title('Gradient magnitude (gradmag)')

Ieq = adapthisteq(dI);
% figure, imshow(Ieq,[])

Ibw = imbinarize(Ieq,0.9*graythresh(Ieq));
% figure, imshow(Ibw)

Ifilled = imfill(Ibw,'holes');
% figure, imshow(Ifilled)

Iopened = imopen(Ifilled, ones(ceil(5*BINNING),ceil(5*BINNING)));
% figure, imshow(Iopened)

Icleared = bwareaopen(Iopened,ceil(40*BINNING));
% figure, imshow(Icleared)

IbwPerim = bwperim(Icleared);
overlay = imoverlay(Ieq, IbwPerim, [.3 1 .3]);
% figure, imshow(overlay)

quartiles = quantile(Ieq(:),3);
maskEM = imextendedmax(Ieq, quartiles(1));
% figure, imshow(maskEM)

maskEM = imclose(maskEM, ones(5,5));
maskEM = imfill(maskEM, 'holes');
maskEM = bwareaopen(maskEM, 40);
overlay2 = imoverlay(Ieq, IbwPerim | maskEM, [.3 1 .3]);
% figure, imshow(overlay2)

IeqComplement = imcomplement(Ieq);

Imod = imimposemin(IeqComplement, ~Icleared | maskEM);

L = watershed(Imod);
% figure, imshow(label2rgb(L))

% showWatershedProcess(dI,Icleared,overlay,maskEM,overlay2,label2rgb(L))

properties = regionprops(L,'BoundingBox','Area');

counter = 1;
for i=1:length(properties)
	
	if properties(i).Area > 100
		imageStruct.boundingBox(counter,:) = properties(i).BoundingBox;
		counter = counter + 1;
	end
	
end

imageStruct.cellN(1,1) = counter - 1;

end

