
% close all other windows
close all
imtool close all

% add the functions to the path
addpath(genpath('functions'));

global SITEN

SITEN = 3;

runMode = 'test'; % 'test' OR 'full'

%% IMPORT DATA

baseFolder = fullfile('~','Desktop','data');

if strcmp(runMode,'test')
	experimentStr = {'exp2','exp3','exp4','exp5'};
	exp = createExperimentStruct(experimentStr);

	exp(1).local_quench = {'60x','quench'};
	exp(1).conditionStr = {'WT'};
	exp(1).condWells(1,:) = {'C02'};
	
	exp(2).local_quench = {'60x','quench'};
	exp(2).conditionStr = {'WT'};
	exp(2).condWells(1,:) = {'C02'};
	
	exp(3).local_quench = {'60x','quench'};
	exp(3).conditionStr = {'WT'};
	exp(3).condWells(1,:) = {'C02'};
	
	exp(4).local_quench = {'60x','quench'};
	exp(4).conditionStr = {'WT'};
	exp(4).condWells(1,:) = {'C02'};
		
	cond = createConditionStruct(exp);
	cond = findImagePathsPerCondition(cond,exp,baseFolder,'60x');
		
elseif strcmp(runMode,'full')
	inputData
	cond = createConditionStruct(exp);
	cond = findImagePathsPerCondition(cond,exp,baseFolder,'60x');
end

disp('Completed importing data')

%% DECLARE GLOBAL VARIABLES

global BINNING EXTRA

BINNING = 1 / 1;
EXTRA = ceil(BINNING*20);


%% SEGMENTATION

close all

conditionN = length(cond);

for j=1:conditionN
	for i=1:cond(j).imageN		

		cond(j).imageLocal(i) = imgSegmentWatershed(cond(j).imageLocal(i));

	end
end

disp('Completed image segmentation')

%% FILTERING

for j=1:conditionN
	for i=1:cond(j).imageN
		
		cond(j).imageLocal(i).cellN = cond(j).imageLocal(i).cellN(1);
		
		cond(j).imageLocal(i) = imgFilterEdges(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFindBackground(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFilterAbuttingCells(cond(j).imageLocal(i));
		
		cond(j).imageLocal(i) = imgFindCellDimensions(cond(j).imageLocal(i));

		cond(j).imageLocal(i) = imgFilterCellSize(cond(j).imageLocal(i));
		
	end
end

disp('Completed image filtering')

%% DISTANCE MAP

for j=1:conditionN
	for i=1:cond(j).imageN
		
		cond(j).imageLocal(i) = distanceMap(cond(j).imageLocal(i));

	end
end

disp('Completed image processing')


%% ANALYSIS

close all

for i=1:length(cond)
	fullCellN = vertcat(cond(i).imageLocal.cellN);
	cond(i).cellN = sum(fullCellN(:,end));
	cond(i) = collectRatioData(cond(i));
end

disp([cond.mutation])
disp(([cond.hits]./[cond.cellN])*100)
disp([cond.cellN])

a=1;
b=3;

% for i=1:cond(a).imageLocal(b).cellN(end)
% 	figure
% 	plotMeanIntensity(cond(a).imageLocal(b),i)
% end
% [maxGrad, maxGradLoc] = findGradient(cond(a).imageLocal(b))

for i=1:length(cond)
	figure
	plotRedYelCorrelation(cond(i))
end

%% DISPLAY

close all

x=1;
y=1;

cond(x).imageLocal(y).cellN
[maxGrad, maxGradLoc] = findGradient(cond(x).imageLocal(y));
% imgDisplay(cond(x).imageLocal(y))
for i=1:cond(x).imageLocal(y).cellN(end)
	
	str1 = sprintf('in %g\nout %g\nmem %g'...
		,round(cond(x).imageLocal(y).yelInsideCell(i),4)...
		,round(cond(x).imageLocal(y).yelOutsideCell(i),4)...
		,round(cond(x).imageLocal(y).yelMembrane(i),4));
	
	str2 = sprintf('max %g\nloc %g'...
		,round(maxGrad(i),4)...
		,maxGradLoc(i));
	
	dim1 = [.6 .8 .1 .1];
	dim2 = [.77 .8 .1 .1];
	
	figure
	subplot(4,5,1)
	cellDisplay(cond(x).imageLocal(y),'yel',i)
	subplot(4,5,2)
	cellDisplay(cond(x).imageLocal(y),'red',i)
	subplot(4,5,3)
	cellDisplay(cond(x).imageLocal(y),'bw',i)
	annotation('textbox',dim1,'String',str1,'FitBoxToText','on');
	annotation('textbox',dim2,'String',str2,'FitBoxToText','on');
	subplot(4,1,[2,3,4])
	plotMeanIntensity(cond(x).imageLocal(y),i)
	
end


