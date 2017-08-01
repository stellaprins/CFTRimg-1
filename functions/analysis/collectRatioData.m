function [conditionStruct] = collectRatioData( conditionStruct )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

yelRatioMembraneIn = vertcat(conditionStruct.imageLocal.yelRatioMembraneIn);
yelRatioOutIn = vertcat(conditionStruct.imageLocal.yelRatioOutIn);

conditionStruct.hits = sum(yelRatioOutIn < 0.9 & yelRatioMembraneIn > 1);

end

