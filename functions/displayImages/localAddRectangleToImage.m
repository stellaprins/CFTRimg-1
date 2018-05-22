function plotAxes = localAddRectangleToImage( plotAxes, boundingBoxes )
%LOCAL_ADD_RECTANGLE_TO_IMAGE Draws rectangles around the cells given in
%'boundingBoxes'.
%		Run after localDisplayImage function.
%
%		plotAxes are the axes to which you wish to add rectangles.
%
%		rectBB = [topLeftXval topLeftYval width height]
%		boundingBox = [topLeftXval topLeftYval width height], though not
%		integers.

global BINNING

for i = 1:size(boundingBoxes,1)
	currentBB = boundingBoxes(i,:);
	rectBB(1) = floor(currentBB(1)) ;
	rectBB(2) = ceil(currentBB(2)) ;
	rectBB(3) = currentBB(3) ;
	rectBB(4) = currentBB(4) ;
	rectangle(plotAxes,'Position',rectBB,...
				'EdgeColor','w',...
		'LineWidth', 1.5*BINNING,...
		'LineStyle','-')
	hold on
end


end

