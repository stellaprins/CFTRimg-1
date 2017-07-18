function showDistanceMapProcess( ...
	redCropped,yelCropped,BW,positiveDistanceMap,membraneBW )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

figure
subplot(1,5,1), imshow(redCropped,[])
subplot(1,5,2), imshow(yelCropped,[])
subplot(1,5,3), imshow(BW)
subplot(1,5,4), imshow(positiveDistanceMap,[])
subplot(1,5,5), imshow(membraneBW)


end

