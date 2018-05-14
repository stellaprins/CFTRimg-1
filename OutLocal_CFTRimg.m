
saveLocalResultsHere  ='segmentation_check2002.xls';

conditionN						= length(resultsLocal);

subplotDimM = 2; % ceil(sqrt(conditionN));
subplotDimN = 3; % ceil(sqrt(conditionN));

%% LOCALISATION OUTPUT

if ispc == true
	
	outputResultsLocalToExcelPC(resultsLocal,saveLocalResultsHere)
	
elseif isunix==true

	outputResultsLocalToExcelMAC(resultsLocal,saveLocalResultsHere)
	
end


%% KSTEST, QQ-PLOTS & FREQUENCY DISTRIBUTIONS (TO TEST NORMALITY)
% perform the Kolmogorov-Smirnov test to see if data is normally
% distributed. 1 means NOT normally distributed at 0.05 significance.
KSTestResults = zeros(conditionN,1);
KSTestPValues = zeros(conditionN,1);
for i=1:conditionN
	
	res = resultsLocal(i);
	memDensity = res.yelMembrane ./ res.redEntire;
	[h,p,ksstat] = kstest(memDensity);
	KSTestResults(i) = h;
	KSTestPValues(i) = p;

end

plotLocalQQPlot(resultsLocal, subplotDimM, subplotDimN )

plotLocalHistogram(resultsLocal, subplotDimM, subplotDimN )


%% FIND STATISTICS TO FIND WHICH CONDITIONS ARE SIGNIFICANTLY DIFFERENT
% Before running this section, it is important to verify that your data is
% NOT normally distributed. The section above allows for this. If your data
% IS normally distributed a test other than the Kruskal-Wallis must be
% employed, i.e. the two-way ANOVA.
close all
cellN       = sum(vertcat(resultsLocal.localCellN));
statsData   = zeros(cellN,1);
group       = cell(cellN,1);
cellCount   = 1;

% arrange the data for the kruskalWallis function.
for i=1:conditionN
	res = resultsLocal(i);
	statsData(cellCount:(cellCount+res.localCellN-1)) = ...
    res.yelMembrane ./ res.redEntire;
	group(cellCount:(cellCount+res.localCellN-1)) = {res.mutation};
	cellCount = cellCount + res.localCellN;
end

% perform the Kruskal-Wallis test, and also use the 'multcompare' function
% to find the p-values for each pairwise comparison.
[pKruskalWallis, statsKW] = plotLocalKruskalWallis(statsData,group);
figure
[c,m,~,gnames] = multcompare(statsKW,'CType','dunn-sidak');

% the multiple comparison p-values are stored in array c. However they are
% difficult to read in this form. Therefore, transfer the data into
% 'multComparePValues'.
comparisonN = ((conditionN-1)*conditionN)/2;
multComparePValues = cell(comparisonN,3);
for i=1:comparisonN
	multComparePValues{i,1} = gnames{c(i,1)};
	multComparePValues{i,2} = gnames{c(i,2)};
	multComparePValues{i,3} = c(i,6);
end

%% CORRELATION PLOTS
% plot redEntire data against either yelEntire or yelMembrane (second
% parameter). It is important to see whether these data are correlated as
% it implies the validity of memDensity measure (yelMem / redEnt).

close all

redYelCorrStats = cell(conditionN + 1,4);
redYelCorrStats(1,:) = {'Condition','R value','Slope','MSE'};

figure
for i=1:conditionN
	redYelCorrStats{i+1,1} = resultsLocal(i).mutation;
  subplot( subplotDimM, subplotDimN, i )
	stats = plotLocalRedYelCorr(resultsLocal(i),'membrane');
	redYelCorrStats(i+1,2:end) = num2cell(stats);
end

disp(redYelCorrStats)

%% IMAGE DISPLAY (with all selected cells boxed)
close all

x=5; % plate
y=29; % image number

fprintf('\nImage %d on plate %d has %d cells.\n'...
	,y,x,plate(x).imageLocal(y).cellN(end))

allBoundingBoxes = plate(x).imageLocal(y).boundingBox(:,:);

figure
localDisplayImage(plate(x).imageLocal(y),'red')
localAddRectangleToImage( allBoundingBoxes )
figure
localDisplayImage(plate(x).imageLocal(y),'yel')
localAddRectangleToImage( allBoundingBoxes )
figure
localDisplayImage(plate(x).imageLocal(y),'combine')
	

%% CELL DISPLAY
% close all
x=5; % plate
y=29; % image number

fprintf('\nImage %d on plate %d has %d cells.\n'...
	,y,x,plate(x).imageLocal(y).cellN(end))

for i=4
	figure('position',[400 400 500 600])
	subplot(3,3,1)
	cellDisplay(plate(x).imageLocal(y),'red',i)
	subplot(3,3,2)
	cellDisplay(plate(x).imageLocal(y),'yel',i)
	subplot(3,3,3)
	cellDisplay(plate(x).imageLocal(y),'bw',i)
	subplot(3,1,[2,3],'position',[0.12 0.1 0.74 0.54])
	plotFOverDistance(plate(x).imageLocal(y),i)
end

%% OUTPUT CELLS TO FILE

tic;

saveLocation = 'cells_segmentation_2102';

fprintf('Saving cell images...\n')

labelAndSaveCells(resultsLocal,plate,saveLocation)

fprintf('Done\n')

toc
