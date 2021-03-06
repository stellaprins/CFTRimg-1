
% close all other windows
close all
imtool close all

% add the functions to the path
addpath(genpath('functions'));

global SITEN

SITEN = 9;

runMode = 'test'; % 'test' OR 'full'

%% IMPORT DATA

baseFolder = fullfile('~','Desktop','data');

if strcmp(runMode,'test')
	experimentStr = {'exp1'};
	exp = createExperimentStruct(experimentStr);

	exp(1).local_quench = {'60x'};
	exp(1).conditionStr = {'WT','F508del','R1070W'};
	
	exp(1).condWells(1,:) = {'B02'};
	exp(1).condWells(2,:) = {'B03'};
	exp(1).condWells(3,:) = {'B04'};
		
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

		cond(j).images(i) = imgSegmentWatershed(cond(j).images(i));

	end
end

disp('Completed image segmentation')

%% FILTERING

for j=1:conditionN
	for i=1:cond(j).imageN
		
		cond(j).images(i).cellN = cond(j).images(i).cellN(1);
		
		cond(j).images(i) = imgFilterEdges(cond(j).images(i));
		
		cond(j).images(i) = imgFindBackground(cond(j).images(i));
		
		cond(j).images(i) = imgFilterAbuttingCells(cond(j).images(i));
		
		cond(j).images(i) = imgFindCellDimensions(cond(j).images(i));

		cond(j).images(i) = imgFilterCellSize(cond(j).images(i));
		
	end
end

disp('Completed image filtering')

%% DISTANCE MAP

for j=1:conditionN
	for i=1:cond(j).imageN
		
		cond(j).images(i) = distanceMap(cond(j).images(i));

	end
end

disp('Completed image processing')


%% ANALYSIS

close all

for i=1:length(cond)
	fullCellN = vertcat(cond(i).images.cellN);
	cond(i).cellN = sum(fullCellN(:,end));
	cond(i) = collectRatioData(cond(i));
end

disp([cond.mutation])
disp([cond.hits])
disp([cond.cellN])

a=3;
b=158;

plotMeanIntensity(cond(a).images(b))

for i=1:length(cond)
	plotRedYelCorrelation(cond(i))
end

%% DISPLAY

close all

x=3;
y=158;

cond(x).images(y).cellN
imgDisplay(cond(x).images(y))
for i=1:cond(x).images(y).cellN(end)
	figure
	subplot(1,3,1)
	cellDisplay(cond(x).images(y),'yel',i)
	title(sprintf('inside=%g\noutside=%g\nmembrane=%g'...
		,round(cond(x).images(y).yelInsideCell(i),4)...
		,round(cond(x).images(y).yelOutsideCell(i),4)...
		,round(cond(x).images(y).yelMembrane(i),4)))
	subplot(1,3,2)
	cellDisplay(cond(x).images(y),'red',i)
	subplot(1,3,3)
	cellDisplay(cond(x).images(y),'bw',i)
	
end


