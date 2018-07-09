function [ imageStruct ] = calculateConcIodine( imageStruct )
%CALCULATE_CONC_IODINE Find the point in the time series, where the
%influx of iodine is at its maximum.
%   Log both the value of maximum influx and the time point at which it
%   occurs.

timeline = imageStruct.timeline;
startPeriodOfInterest = timeline(2);
timePointN = timeline(end);

timeStep = imageStruct.timeStep;

yelInside = imageStruct.yelInsideOverT;

concIodine = 1.9 * ((1-yelInside)./yelInside); % mM

gradIodine = zeros(timePointN-1,1);

for i=1:length(gradIodine)
	
	gradIodine(i) = (concIodine(i+1) - concIodine(i)) / timeStep; % mM s^(-1)
	
end

imageStruct.maxGradIodine = ...
	max(gradIodine(startPeriodOfInterest:end));
location = (1:length(gradIodine))' .* ...
	(gradIodine==max(gradIodine(startPeriodOfInterest:end)));

imageStruct.maxGradLocation = max(location);


end

