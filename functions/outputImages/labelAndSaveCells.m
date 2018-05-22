function labelAndSaveCells( resultsStructArray ,plateStructArray ...
	,saveLocation )
%LABEL_AND_SAVE_CELLS save each cell image (red and yel) to file labelled with rho value


conditionN = length(resultsStructArray);

for j=1:conditionN
	resultsStruct = resultsStructArray(j);
	cellN = length(resultsStruct.cellLocation);
	
	mkdir(fullfile(saveLocation,resultsStruct.mutation))
	
	for i=1:cellN
		
		plateIdx = resultsStruct.cellLocation(i,1);
		imageIdx = resultsStruct.cellLocation(i,2);
		bBoxIdx = resultsStruct.cellLocation(i,3);
		
		rhoVal = resultsStruct.normMemDens(i);
		
		[redCellImage, yelCellImage] = ...
		cellWithBorder(plateStructArray(plateIdx).imageLocal(imageIdx),bBoxIdx);

		textStr = sprintf('rho = %0.3f',rhoVal);
		
		redTextImage = insertText(redCellImage,[1 1],textStr,'textcolor','white','boxcolor','black');
		yelTextImage = insertText(yelCellImage,[1 1],textStr,'textcolor','white','boxcolor','black');
		
		redFilename = sprintf('red-%d_%d_%d.jpg',plateIdx,imageIdx,bBoxIdx);
		yelFilename = sprintf('yel-%d-%d-%d.jpg',plateIdx,imageIdx,bBoxIdx);
		
		imwrite( redTextImage, fullfile(saveLocation,resultsStruct.mutation,redFilename) , 'jpg' )
		imwrite( yelTextImage, fullfile(saveLocation,resultsStruct.mutation,yelFilename) , 'jpg' )
		
	end
	
end

end