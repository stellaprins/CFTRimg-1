function labelAndSaveCells( resultsStructArray ,plateStructArray ...
	,saveLocation )
%LABELANDSAVECELLS Summary of this function goes here
%   Detailed explanation goes here

conditionN = length(resultsStructArray);

for j=1:conditionN
	resultsStruct = resultsStructArray(j);
	cellN = length(resultsStruct.cellLocation);
	
	mkdir(fullfile(saveLocation,resultsStruct.mutation))
	
	for i=1:cellN
		
		plateIdx = resultsStruct.cellLocation(i,1);
		imageIdx = resultsStruct.cellLocation(i,2);
		bBoxIdx = resultsStruct.cellLocation(i,3);
		
		rhoVal = resultsStruct.yelMembrane(i) / resultsStruct.redEntire(i);
		
		redCellImage = cellWithBorder(plateStructArray(plateIdx).imageLocal(imageIdx),'redBorder',bBoxIdx);
		yelCellImage = cellWithBorder(plateStructArray(plateIdx).imageLocal(imageIdx),'yelBorder',bBoxIdx);

		textStr = sprintf('%d,%d,%d\nrho = %0.4f',plateIdx,imageIdx,bBoxIdx,rhoVal);
		
		redTextImage = insertText(redCellImage,[1 1],textStr,'textcolor','white','boxcolor','black');
		yelTextImage = insertText(yelCellImage,[1 1],textStr,'textcolor','white','boxcolor','black');
		
		redFilename = sprintf('red-%d_%d_%d.jpg',plateIdx,imageIdx,bBoxIdx);
		yelFilename = sprintf('yel-%d-%d-%d.jpg',plateIdx,imageIdx,bBoxIdx);
		
		imwrite( redTextImage, fullfile(saveLocation,resultsStruct.mutation,redFilename) , 'jpg' )
		imwrite( yelTextImage, fullfile(saveLocation,resultsStruct.mutation,yelFilename) , 'jpg' )
		
	end
end






end