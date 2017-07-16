function [ imageStruct ] = imgSegmentWatershed( imageStruct )
%IMGSEGMENTWATERSHED Summary of this function goes here
%   Detailed explanation goes here

global BINNING

I = imread(imageStruct.path);
doubleI = im2double(I);
adjustedI = imadjust(doubleI,[min(doubleI(:)); max(doubleI(:))]...
	,[0; 1]);
% imshow(adjustedI)

 
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
% figure
% imshow(gradmag,[]), title('Gradient magnitude (gradmag)')

x=30*BINNING;
se = strel('disk', x);
% Io = imopen(I, se);
% doubleIo = im2double(Io);
% adjustedIo = imadjust(doubleIo,[min(doubleIo(:)); max(doubleIo(:))],[0; 1]);
% figure
% imshow(adjustedIo), title('Opening (Io)')


Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
% doubleIobr = im2double(Iobr);
% adjustedIobr = imadjust(doubleIobr,[min(doubleIobr(:)); max(doubleIobr(:))],[0; 1]);
% figure
% imshow(adjustedIobr), title('Opening-by-reconstruction (Iobr)')


% Ioc = imclose(Io, se);
% doubleIoc = im2double(Ioc);
% adjustedIoc = imadjust(doubleIoc,[min(doubleIoc(:)); max(doubleIoc(:))],[0; 1]);
% figure
% imshow(adjustedIoc), title('Opening-closing (Ioc)')


Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
% doubleIobrcbr = im2double(Iobrcbr);
% adjustedIobrcbr = imadjust(doubleIobrcbr...
% 	,[min(doubleIobrcbr(:)); max(doubleIobrcbr(:))],[0; 1]);
% figure
% imshow(adjustedIobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')


fgm = imregionalmax(Iobrcbr);
% figure
% imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')


% I2 = adjustedI;
% I2(fgm) = 255;
% figure
% imshow(I2), title('Regional maxima superimposed on original image (I2)')


se2 = strel(ones(ceil(x/4),ceil(x/4)));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, x);
% I3 = adjustedI;
% I3(fgm4) = 255;
% figure
% imshow(I3)
% title('Modified regional maxima superimposed on original image (fgm4)')


thresh=graythresh(I);
bw = imbinarize(Iobrcbr,thresh*0.8);
% figure
% imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')


D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
% figure
% imshow(bgm), title('Watershed ridge lines (bgm)')


gradmag2 = imimposemin(gradmag, bgm | fgm4);

L = watershed(gradmag2);
properties = regionprops(L,'BoundingBox'...
						,'MajorAxisLength','MinorAxisLength'); 


% I4 = adjustedI;
% I4(imdilate(L == 0, ones(ceil(x/6), ceil(x/6))) | bgm | fgm4) = 255;
% figure
% imshow(I4)
% title('Markers and object boundaries superimposed on original image (I4)')

% Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
% figure
% imshow(Lrgb)
% title('Colored watershed label matrix (Lrgb)')

% figure
% imshow(adjustedI)
% hold on
% himage = imshow(Lrgb);
% himage.AlphaData = 0.3;
% title('Lrgb superimposed transparently on original image')



for i=1:length(properties)
	imageStruct.boundingBox(i,:) = properties(i).BoundingBox;
end
imageStruct.cellLength = [properties.MajorAxisLength]';
imageStruct.cellWidth = [properties.MinorAxisLength]';
imageStruct.cellN(1,1) = length(properties);

end

