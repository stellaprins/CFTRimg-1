function localAddRectangleToImage( boundingBoxes )
%LOCAL_ADD_RECTANGLE_TO_IMAGE Draws rectangles around the cells given in
%'boundingBoxes'.
%		Run after localDisplayImage function.
%
%		rectBB = [topLeftXval topLeftYval width height]
%		boundingBox = [topLeftXval topLeftYval width height], though not
%		integers.

for i = 1:length(boundingBoxes)
	currentBB = boundingBoxes(i,:);
	rectBB(1) = ceil(currentBB(1)) ;
	rectBB(2) = ceil(currentBB(2)) ;
	rectBB(3) = currentBB(3) ;
	rectBB(4) = currentBB(4) ;
	rectangle('Position',rectBB,...
				'EdgeColor','w',...
		'LineWidth', 1.5,...
		'LineStyle','-')
	hold on
end


end

