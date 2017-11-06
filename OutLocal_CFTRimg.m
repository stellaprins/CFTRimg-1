
saveLocalResultsHere  ='C:\Users\StellaPrins\Desktop\local_VX809_28.xls';

conditionN						= length(resultsLocal);
colors								= get(groot,'DefaultAxesColorOrder');

%% LOCALISATION OUTPUT

meanYFPEntire			= zeros(1,conditionN);
meanYFPMembrane   = zeros(1,conditionN);
stdYFPEntire			= zeros(1,conditionN);
stdYFPMembrane		= zeros(1,conditionN);
medianYFPMembrane	= zeros(1,conditionN);
iqrYFPMembrane    = zeros(1,conditionN);
meanRedEntire     = zeros(1,conditionN);
stdRedEntire			= zeros(1,conditionN);

for i=1:conditionN
	res										= resultsLocal(i);
	meanYFPEntire(i)			= mean(res.yelEntire ./ res.redEntire);
	stdYFPEntire(i)				= std(res.yelEntire ./ res.redEntire);
	meanYFPMembrane(i)		= mean(res.yelMembrane ./ res.redEntire);
	stdYFPMembrane(i)			= std(res.yelMembrane ./ res.redEntire);
 	medianYFPMembrane(i)	= median(res.yelMembrane ./ res.redEntire);
 	iqrYFPMembrane(i)			= iqr(res.yelMembrane ./ res.redEntire);
	meanRedEntire(i)      = mean(res.redEntire);
	stdRedEntire(i)       = std(res.redEntire);
end
			
% outputResultsLocalToExcel(resultsLocal,saveLocalResultsHere)
condition   = vertcat(cellstr('condition'),cellstr({resultsLocal.mutation}'));
N           = vertcat(cellstr('N'),num2cell([resultsLocal.localCellN]'));
Ymem        = vertcat((horzcat(cellstr('Membrane density'), ...
              cellstr('std'))),num2cell([meanYFPMembrane; stdYFPMembrane]'));
results			=	horzcat(condition,N,Ymem)

xlswrite(saveLocalResultsHere,results);


%% QQ-PLOTS & FREQUENCY DISTRIBUTIONS (TO TEST NORMALITY)

for b  = 1:conditionN
	MembraneDensity = resultsLocal(b).yelMembrane./resultsLocal(b).redEntire;
	subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),b);
		qqplot(MembraneDensity);
		yLab = ylabel(sprintf('F_{YFP,membrane} / F_{mCh,cell}\nQuantiles'));
		set(yLab,'fontsize',9)
		xLab = xlabel(sprintf('Standard Normal Quantiles'));
		set(xLab,'fontsize',8)
		title(resultsLocal(b).mutation);
end

figure;

for b  = 1:conditionN
	MembraneDensity = resultsLocal(b).yelMembrane./resultsLocal(b).redEntire;
	subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),b);
		hist(MembraneDensity);
		xLab = xlabel('F_{YFP,membrane} / F_{mCh,cell}');
		set(xLab,'fontsize',9)
		yLab = ylabel('Frequency');
		set(yLab,'fontsize',8)
		title(resultsLocal(b).mutation);
end

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
[c,m,~,gnames] = multcompare(statsKW,'CType','dunn-sidak');


%% CORRELATION PLOTS

close all

for i=1:ceil(length(resultsLocal)/2)
    subplot( ceil(sqrt((length(resultsLocal)/2)/1.5)),...
             ceil(sqrt((length(resultsLocal)/2)*1.5)), i)
	plotLocalRedYelCorr(resultsLocal(i),'entire');
end

figure;

for i=ceil(length(resultsLocal)/2):ceil(length(resultsLocal))
    k=i-((length(resultsLocal)/2)-1);
    subplot( ceil(sqrt((length(resultsLocal)/2)/1.5)),...
             ceil(sqrt((length(resultsLocal)/2)*1.5)), k);
	plotLocalRedYelCorr(resultsLocal(i),'entire');
end

%% IMAGE DISPLAY
close all

x=1; % plate
y=5; % image number

fprintf('\nImage %d on plate %d has %d cells.\n'...
	,y,x,plate(x).imageLocal(y).cellN(end))

% display the image
figure
imgDisplay(plate(x).imageLocal(y),'yel')

% display image with 2 cells boxed
cell1 = 1;
cell2 = 4;
boundingBox1 = plate(x).imageLocal(y).boundingBox(cell1,:);
boundingBox2 = plate(x).imageLocal(y).boundingBox(cell2,:);
figure
imgDisplayRectangle(plate(x).imageLocal(y),'red',boundingBox1,boundingBox2)

%% CELL DISPLAY
close all
x=1; % plate
y=1; % image number

fprintf('\nImage %d on plate %d has %d cells.\n'...
	,y,x,plate(x).imageLocal(y).cellN(end))

for i=1:3
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
