

meanMaxGrad = zeros(length(cond),1);
stdMaxGrad = zeros(length(cond),1);
meanMaxGradLoc = zeros(length(cond),1);
stdMaxGradLoc = zeros(length(cond),1);

maxGradFull = [];
maxGradLocFull = [];

for j=1:length(cond)
	for i=1:cond(j).imageN
		[maxGrad, maxGradLoc] = findGradient(cond(j).images(i));
		maxGradFull = vertcat(maxGradFull,maxGrad);
		maxGradLocFull = vertcat(maxGradLocFull,maxGradLoc);
	end
	meanMaxGrad(j) = mean(maxGradFull);
	stdMaxGrad(j) = std(maxGradFull);
	meanMaxGradLoc(j) = mean(maxGradLocFull);
	stdMaxGradLoc(j) = std(maxGradLocFull);
end