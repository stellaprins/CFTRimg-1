
% close all other windows
close all
imtool close all

% add the functions to the path
addpath(genpath('functions'));

global BINNING EXTRA

BINNING = 1 / 1;
EXTRA = ceil(BINNING*20);

siteN = 9;

runMode = 'test'; % 'test' OR 'full'

%% CREATE DATA STRUCTURES

if strcmp(runMode,'test')
	experiment = 'exp1';
	magnification = '60x';
	conditionsStr = {'WT'};
	cond = createConditions(conditionsStr);
	cond(1).wells = {'B02'};
elseif strcmp(runMode,'full')
	experiment = 'exp1';
	magnification = '60x';
	conditionsStr = {'WT','F508del','R1070W'};
	cond = createConditions(conditionsStr);
	cond(1).wells = {'B02','C02','D02','E02','F02','G02'};
	cond(2).wells = {'B03','C03','D03','E03','F03','G03'};
	cond(3).wells = {'B04','C04','D04','E04','F04','G04'};
end

%% IMPORT THE DATA

fileFolder = fullfile('~','Desktop','data',experiment,magnification);
filePrefix = strcat(experiment,'_',magnification,'_');

conditionN = length(cond);

for i=1:conditionN
	
	cond(i).imageN = length(cond(i).wells)*siteN;
	
	redPathArray = cell(length(cond(i).wells)*siteN,1);
	yelPathArray = cell(length(cond(i).wells)*siteN,1);
	
	for j=1:length(cond(i).wells)
		
		% red
		filename = strcat(filePrefix,cond(i).wells{j},'_s*_w2.TIF');
		redDirOutput = dir(fullfile(fileFolder,filename));
		
		% yellow
		filename = strcat(filePrefix,cond(i).wells{j},'_s*_w1.TIF');
		yelDirOutput = dir(fullfile(fileFolder,filename));

		for p = 1:siteN
			redPathArray{(j-1)*siteN + p} = fullfile(fileFolder,redDirOutput(p).name);
			yelPathArray{(j-1)*siteN + p} = fullfile(fileFolder,yelDirOutput(p).name);
		end
		
	end
	
	cond(i).images = createImageStruct(redPathArray,yelPathArray);
	
end

%% SEGMENTATION

close all
for j=1:conditionN
	for i=1:cond(j).imageN

		cond(j).images(i).cellN = [];

		cond(j).images(i) = imgSegment(cond(j).images(i));

		cond(j).images(i) = imgFilterEdges(cond(j).images(i));

		cond(j).images(i) = imgFindCellDimensions(cond(j).images(i));

		cond(j).images(i) = imgFilterCellSize(cond(j).images(i));

% 	 	cond(j).images(i).cellN

	end
end

%% PROCESSING

for j=1:conditionN
	for i=1:cond(j).imageN

		cond(j).images(i) = distanceMap(cond(j).images(i));

	end
end


%% RESULTS

close all

x=1;
y=1;

cond(x).images(y).cellN
figure
imgDisplay(cond(x).images(y))
for i=1:cond(x).images(y).cellN(end)
	figure
	cellDisplay(cond(x).images(y),'yel',i)
	title(sprintf('inside=%g\noutside=%g\nmembrane=%g'...
		,round(cond(x).images(y).meanInsideCell(i),4)...
		,round(cond(x).images(y).meanOutsideCell(i),4)...
		,round(cond(x).images(y).meanMembrane(i),4)))
end
