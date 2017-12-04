function outputQuenchTimelineToExcelMAC (...
	resultsStructArray , saveLocationPath)

conditionN = length(resultsStructArray);

count_col1   = 0;
	for i = 1:conditionN
		count_F     = length(resultsStructArray(i).maxGradTest);
		count_DMSO  = length(resultsStructArray(i).maxGradControl);
		count_col1  = count_col1 + count_F*2+count_DMSO*2+8;
	end

	l      = vertcat(resultsStructArray(1).yelInsideOverTTest...
		,resultsStructArray(1).yelInsideOverTControl);
	l      = length(l)+2;
	space  = cell(l,count_col1);
	count_col2                   = zeros(1,conditionN);
	for i = 1:conditionN
		results_quenching_timeline  = quenching_timeline(resultsStructArray(i));
		count_F                     = length(resultsStructArray(i).maxGradTest);
		count_DMSO                  = length(resultsStructArray(i).maxGradControl);
		count_col2(1,i)             = count_F*2+count_DMSO*2+8;
		space(:,1+sum(count_col2(1:i-1)):sum(count_col2(1:i)))=results_quenching_timeline;
	end
	
	T = table(space);

	writetable(T,saveLocationPath)
	
end

