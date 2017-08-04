function showWatershedProcess( dI,Icleared,overlay,maskEM,overlay2,color )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

m=2;
n=3;


figure
set(gcf, 'Position', get(0, 'Screensize'));
subplot(m,n,1), imshow(dI,[])
subplot(m,n,2), imshow(Icleared,[])
subplot(m,n,3), imshow(overlay)
subplot(m,n,4), imshow(maskEM)
subplot(m,n,5), imshow(overlay2)
subplot(m,n,6), imshow(color)



end

