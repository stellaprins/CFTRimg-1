%% SET UP RESULTS STRUCT KATIE

resultsLocal1 = createResultsLocalStruct(cond1);
resultsLocal2 = createResultsLocalStruct(cond2);
resultsLocal3 = createResultsLocalStruct(cond3);
resultsLocal4 = createResultsLocalStruct(cond4);
resultsLocal5 = createResultsLocalStruct(cond5);

for i=1:conditionN
	resultsLocal1(i) = filterNegativeMetric(resultsLocal1(i));
	resultsLocal2(i) = filterNegativeMetric(resultsLocal2(i));
	resultsLocal3(i) = filterNegativeMetric(resultsLocal3(i));	
	resultsLocal4(i) = filterNegativeMetric(resultsLocal4(i));
	resultsLocal5(i) = filterNegativeMetric(resultsLocal5(i));	
end

resultsLocal1 = normalizeResultsWT(resultsLocal1);
resultsLocal2 = normalizeResultsWT(resultsLocal2);
resultsLocal3 = normalizeResultsWT(resultsLocal3);	
resultsLocal4 = normalizeResultsWT(resultsLocal4);
resultsLocal5 = normalizeResultsWT(resultsLocal5);


resultsLocal = combineResults(resultsLocal1,resultsLocal2,resultsLocal3...
	,resultsLocal4,resultsLocal5);