function plotLocalHistogram( resultsStruct , M , N )
%PLOT_LOCAL_HISTOGRAM Histograms for each condition in separate subplot
%   The histograms show how close to normally distributed the data are. The
%   parameters of the histograms (bin width and number of bins) are first calculated. 

conditionN = length(resultsStruct);

% concatenate all values relevant for calculating membrane density across
% all conditions
yelMembrane = vertcat(resultsStruct.yelMembrane);
redEntire = vertcat(resultsStruct.redEntire);

% Using the Freedman-Diaconis rule, calculate optimum bin width for each
% condition. Select median density across all conditions
binWidth = zeros(1,conditionN);
for i = 1:conditionN
	
	res = resultsStruct(i);
	memDensity = res.yelMembrane ./ res.redEntire;
	iqrange = iqr(memDensity);
	binWidth(i) = 2 * iqrange * (res.localCellN)^((-1)/3);
	
end
binWidthMedian = median(binWidth);

% caluclate the maximum membrane density to specify the max x-axis value.
maxMembraneDensity = max(yelMembrane ./ redEntire);
maxXValue = maxMembraneDensity + binWidthMedian;

% calculate maximum frequency for each condition
maxFrequency = 0;
for i = 1:conditionN
	res = resultsStruct(i);
	memDensity = res.yelMembrane ./ res.redEntire;
	binsN = ceil(max(memDensity) / binWidthMedian);
	cumulFrequency = zeros(binsN,1);
	frequency = zeros(binsN,1);
	for j=1:binsN
		cumulFrequency(j) = sum(memDensity < j*binWidthMedian);
		if j>1
			frequency(j) = cumulFrequency(j) - cumulFrequency(j-1);
		elseif j==1
			frequency(j) = cumulFrequency(j);
		end
	end
	if max(frequency) > maxFrequency
		maxFrequency = max(frequency);
	end
end

maxYValue =  maxFrequency + 1;

figure
for i = 1:conditionN
	
	membraneDensity = resultsStruct(i).yelMembrane./resultsStruct(i).redEntire;
	
	subplot(M,N,i);
		histogram(membraneDensity,'binWidth',binWidthMedian)
		xlim([0, maxXValue])
		ylim([0, maxYValue])
		xLab = xlabel('F_{YFP,membrane} / F_{mCh,cell}');
		set(xLab,'fontsize',9)
		yLab = ylabel('Frequency');
		set(yLab,'fontsize',8)
		title(resultsStruct(i).mutation);
		
end

end

