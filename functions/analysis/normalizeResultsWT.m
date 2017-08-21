function [ resultsStructArray ] = normalizeResultsWT( resultsStructArray )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

conditionN = length(resultsStructArray);
meanYFPMembrane	= zeros(conditionN,1);
meanYFPEntire	= zeros(conditionN,1);

for i=1:conditionN
	
	res = resultsStructArray(i);

	meanYFPMembrane(i)	= mean(res.yelMembrane ./ res.redEntire);
	meanYFPEntire(i)	= mean(res.yelEntire ./ res.redEntire);

end

normalizeMembrane = 1 / meanYFPMembrane(3);
normalizeEntire = 1 / meanYFPEntire(3);

for i=1:conditionN
	res = resultsStructArray(i);
	resultsStructArray(i).yelMembrane = res.yelMembrane * normalizeMembrane;
	resultsStructArray(i).yelEntire = res.yelEntire * normalizeEntire;
end

end

