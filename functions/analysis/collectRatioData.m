function [conditionStruct] = collectRatioData( conditionStruct )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

yelEntire	= vertcat(conditionStruct.imageLocal.yelEntire);
yelOutside	= vertcat(conditionStruct.imageLocal.yelOutside);
yelMembrane	= vertcat(conditionStruct.imageLocal.yelMembrane);

yelRatioMembraneIn	= yelMembrane ./ yelEntire;
yelRatioOutIn		= yelOutside ./ yelEntire;

conditionStruct.localHits = sum(yelRatioOutIn < 0.9 & yelRatioMembraneIn > 1);

end

