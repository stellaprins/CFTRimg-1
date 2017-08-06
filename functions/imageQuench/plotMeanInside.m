function plotMeanInside( conditionStruct,idx )
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here


meanYel = conditionStruct.imageQuench(idx).yelInsideOverT;

plot(1:70,meanYel)
ylim([0.5 1.6])
title(conditionStruct.mutation)
xlabel('Timepoint')
ylabel('Norm. adj. mean YFP fluorescence within cells')

end

