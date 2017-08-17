function plotMetricHistogram( resultsStructArray )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


for i=1:length(
	
	resStruct = resultsStructArray(i);
	
	fullCellN = vertcat(cond(i).imageLocal.cellN);
	cond(i).localCellN = sum(fullCellN(:,end));
	
	yelMembrane = vertcat(cond(i).imageLocal.yelMembrane);
	yelEntire		= vertcat(cond(i).imageLocal.yelEntire);
	redEntire		= vertcat(cond(i).imageLocal.redEntire);
	
	cond(i).YFPmembrane = yelMembrane ./ redEntire;
	cond(i).YFPentire		= yelMembrane ./ redEntire;
	
	meanYFPEntire(i)		= mean(yelEntire ./ redEntire);
	stdYFPEntire(i)			= std(yelEntire ./ redEntire);
	meanYFPMembrane(i)	= mean(yelMembrane ./ redEntire);
	stdYFPMembrane(i)		= std(yelMembrane ./ redEntire);
	
	statsData(cellCount:(cellCount+cond(i).localCellN-1)) = ...
		yelMembrane ./ redEntire;
	cellCount = cellCount + cond(i).localCellN;
	
	cond(i) = collectRatioData(cond(i));

end

	yelMembrane = vertcat(cond(1).imageLocal.yelMembrane);
	redEntire		= vertcat(cond(1).imageLocal.redEntire);

	WT = yelMembrane ./ redEntire;


end

