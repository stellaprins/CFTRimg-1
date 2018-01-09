function [ distanceMap ] = makeDistanceMap( cellMask )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

positiveDistanceMap = (ceil(bwdist(~cellMask)) - 1) .* cellMask;
negativeDistanceMap = ceil(bwdist(cellMask));
distanceMap = positiveDistanceMap - negativeDistanceMap;

end

