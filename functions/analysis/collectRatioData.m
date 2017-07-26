function [conditionStruct] = collectRatioData( conditionStruct )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

yelRatioMembraneIn = vertcat(conditionStruct.images.yelRatioMembraneIn);
yelRatioOutIn = vertcat(conditionStruct.images.yelRatioOutIn);

conditionStruct.hits = sum(yelRatioOutIn < 0.9 & yelRatioMembraneIn > 1);

end

