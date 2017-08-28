function showQuenchImage( imageStruct )
%UNTITLED19 Summary of this function goes here
%   Detailed explanation goes here

% figure
% subplot(1,3,1)
% imshow(redI,[])
% subplot(1,3,2)
% imshow(yelI,[])
% subplot(1,3,3)
% imshow(mask)

figure
imgDisplayOverlayQuench(imageStruct,'redOverlay')
figure
imgDisplayOverlayQuench(imageStruct,'yelStart')
figure
imgDisplayOverlayQuench(imageStruct,'yelEnd')


end

