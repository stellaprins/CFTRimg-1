function [ imageStruct ] = calculateConcIodine( imageStruct )
%UNTITLED26 Summary of this function goes here
%   Detailed explanation goes here

yelInside = imageStruct.yelInsideOverT;

concIodine = 1.9 * ((1-yelInside)./yelInside); % mM

gradIodine = zeros(69,1);

for i=1:length(gradIodine)
	
	gradIodine(i) = (concIodine(i+1) - concIodine(i)) / 2; % mM s^(-1)
	
end

imageStruct.maxGradIodine = max(gradIodine(26:end));
location = (1:length(gradIodine))' .* (gradIodine==max(gradIodine(26:end)));

imageStruct.maxGradLocation = max(location);


end

