function showDistanceMapProcess( ...
	imageStruct,boundingBox_idx,cellMask,positiveDistanceMap,membraneMask )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

% figure
% subplot(1,5,1), cellDisplay(imageStruct,'red',boundingBox_idx)
% subplot(1,5,2), cellDisplay(imageStruct,'yel',boundingBox_idx)
% subplot(1,5,3), cellDisplay(imageStruct,'bw',boundingBox_idx)
% subplot(1,5,4), imshow(positiveDistanceMap,[])
% subplot(1,5,5), imshow(membraneBW)


figure, cellDisplayOverlay(imageStruct,'redOverlay'...
	,cellMask, membraneMask,boundingBox_idx)
figure, cellDisplay(imageStruct,'bw',boundingBox_idx)
cmapMax = double(ceil(max(positiveDistanceMap(:))));
figure
imshow(label2rgb(positiveDistanceMap,colormap(lines(cmapMax)))...
	,'InitialMagnification','fit')
set(gca,'position',[0 0 1 1])
figure
imshow(membraneMask,'InitialMagnification','fit')
set(gca,'position',[0 0 1 1])
figure, cellDisplayOverlay(imageStruct,'yelOverlay'...
	,cellMask, membraneMask,boundingBox_idx)

end

