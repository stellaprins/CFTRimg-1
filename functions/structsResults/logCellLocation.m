function imageStruct = logCellLocation( imageStruct , plateIdx , imageIdx)
%LOG_CELL_LOCATION log the location of each cell
%		The plate index, image index and bounding box index are saved so that
%		the cells can be found later for image display
cellLocation = zeros(imageStruct.cellN(end),4);

cellLocation(:,1) = plateIdx;
cellLocation(:,2) = str2num(imageStruct.temp);
cellLocation(:,3) = imageIdx;
cellLocation(:,4) = [1:imageStruct.cellN(end)]';

imageStruct.cellLocation = cellLocation;

end

