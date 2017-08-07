function plotMeanInside( conditionStruct,idx )
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here


meanYel = conditionStruct.imageQuench(idx).yelInsideOverT;

plot(1:70,meanYel)
ylim([0 0.04])
title([conditionStruct.mutation,' ',conditionStruct.imageQuench(idx).test_control])
xlabel('Timepoint')
ylabel('Norm. adj. mean YFP fluorescence within cells')

end

