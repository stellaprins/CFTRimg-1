
saveLocalResultsHere  ='segmentation_check2002.xls';

conditionN						= length(resultsLocal);

subplotDimM = 2; % ceil(sqrt(conditionN));
subplotDimN = 3; % ceil(sqrt(conditionN));

colors								= get(groot,'DefaultAxesColorOrder');

%% LOCALISATION OUTPUT

if ispc == true
	
	outputResultsLocalToExcelPC(resultsLocal,saveLocalResultsHere)
	
elseif isunix==true

	outputResultsLocalToExcelMAC(resultsLocal,saveLocalResultsHere)
	
end


%% QQ-PLOTS & FREQUENCY DISTRIBUTIONS (TO TEST NORMALITY)

plotLocalQQPlot(resultsLocal, subplotDimM, subplotDimN )

plotLocalHistogram(resultsLocal, subplotDimM, subplotDimN )


%% STATISTICS
close all
cellN       = sum(vertcat(resultsLocal.localCellN));
statsData   = zeros(cellN,1);
group       = cell(cellN,1);
cellCount   = 1;

for i=1:conditionN
	res = resultsLocal(i);
	statsData(cellCount:(cellCount+res.localCellN-1)) = ...
    res.yelMembrane ./ res.redEntire;
	group(cellCount:(cellCount+res.localCellN-1)) = {res.mutation};
	cellCount = cellCount + res.localCellN;
end

[pKruskalWallis, statsKW] = plotKruskalWallis(statsData,group);
figure;
[c,m,~,gnames] = multcompare(statsKW,'CType','bonferroni');


%% CORRELATION PLOTS

close all
figure;

for i=1:ceil(length(resultsLocal)/2)
    subplot( ceil(sqrt((length(resultsLocal)/2)/1.5)),...
             ceil(sqrt((length(resultsLocal)/2)*1.5)), i)
	plotLocalRedYelCorr(resultsLocal(i),'membrane');
end

figure;

for i=ceil(length(resultsLocal)/2):ceil(length(resultsLocal))
    k=i-((length(resultsLocal)/2)-1);
    subplot( ceil(sqrt((length(resultsLocal)/2)/1.5)),...
             ceil(sqrt((length(resultsLocal)/2)*1.5)), k);
	plotLocalRedYelCorr(resultsLocal(i),'membrane');
end

figure
for i=1:length(resultsLocal)
    subplot(1,length(resultsLocal),i)
	plotLocalRedYelCorr(resultsLocal(i),'membrane');
	hold on
end



%% IMAGE DISPLAY
close all

x=5; % plate
y=29; % image number

fprintf('\nImage %d on plate %d has %d cells.\n'...
	,y,x,plate(x).imageLocal(y).cellN(end))

% display the image
% enter "red", "yel", "blend" as the second argument of imgDisplay.'

figure
imgDisplay(plate(x).imageLocal(y),'blend')

% display image with 2 cells boxed
cell1 = 1;
cell2 = 2;

boundingBox1 = plate(x).imageLocal(y).boundingBox(cell1,:);
boundingBox2 = plate(x).imageLocal(y).boundingBox(cell2,:);

figure
imgDisplayRectangle(plate(x).imageLocal(y),'red',boundingBox1,boundingBox2)
figure
imgDisplayRectangle(plate(x).imageLocal(y),'yel',boundingBox1,boundingBox2)

%% display image with all selected cells boxed
close all

x=5; % plate
y=29; % image number

fprintf('\nImage %d on plate %d has %d cells.\n'...
	,y,x,plate(x).imageLocal(y).cellN(end))

for ii= 1:plate(x).imageLocal(y).cellN(end)
B(ii,:)=plate(x).imageLocal(y).boundingBox(ii,:);	
end

figure
imgDisplayRectangle_SP(plate(x).imageLocal(y),'red',B)
figure
imgDisplayRectangle_SP(plate(x).imageLocal(y),'yel',B)
figure
imgDisplay(plate(x).imageLocal(y),'blend')
	

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
