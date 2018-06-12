function imageStruct = logCellLocation( imageStruct , plateIdx , imageIdx)
%LOG_CELL_LOCATION log the location of each cell
%		The plate index, image index and bounding box index are saved so that
%		the cells can be found later for image display

cellLocation = cell(imageStruct.cellN(end),4);

cellLocation(:,1) = {imageStruct.plateStr};
cellLocation(:,2) = {plateIdx};
cellLocation(:,3) = {imageIdx};
for i=1:imageStruct.cellN(end)
	cellLocation(i,4) = {i};
end

imageStruct.cellLocation = cellLocation;

end

