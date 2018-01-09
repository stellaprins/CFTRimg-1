function imageStruct = logCellLocation( imageStruct , plateIdx , imageIdx)
%LOGCELLLOCATION Summary of this function goes here
%   Detailed explanation goes here

cellLocation = zeros(imageStruct.cellN(end),3);

cellLocation(:,1) = plateIdx;
cellLocation(:,2) = imageIdx;
cellLocation(:,3) = [1:imageStruct.cellN(end)]';

imageStruct.cellLocation = cellLocation;

end

