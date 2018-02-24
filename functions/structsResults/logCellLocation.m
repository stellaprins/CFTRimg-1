function imageStruct = logCellLocation( imageStruct , plateIdx , imageIdx)
%LOG_CELL_LOCATION log the location of each cell
%		The plate index, image index and bounding box index are saved so that
%		the cells can be found later for image display


cellLocation = zeros(imageStruct.cellN(end),3);

cellLocation(:,1) = plateIdx;
cellLocation(:,2) = imageIdx;
cellLocation(:,3) = [1:imageStruct.cellN(end)]';

imageStruct.cellLocation = cellLocation;

end

