function plotRedYelCorrelation( conditionStruct )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mutation = conditionStruct.mutation;
yelInside = vertcat(conditionStruct.images.yelInsideCell);
redInside = vertcat(conditionStruct.images.redInsideCell);

R = corrcoef(redInside,yelInside);
r = R(1,2);
dim = [.7 0 .2 .2];
str = sprintf('R = %0.5f',r);

figure
scatter(redInside,yelInside)
title(mutation)
xlabel('Mean mCherry fluorescence inside the cell')
ylabel('Mean YFP fluorescence inside the cell')
annotation('textbox',dim,'String',str,'FitBoxToText','on');



