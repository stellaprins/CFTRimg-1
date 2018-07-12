%% RESULTS SUMMARY

desktopDir = getDesktopDir();
saveLocalResultsFolder = fullfile(desktopDir,'resultsLocal');
conditionN = length(resultsLocal);
conditionsSummary = cell(conditionN + 1,3);
conditionsSummary(1,:) = {'index','condition','normalized to'};
fullConditionNames = cell(conditionN,1);

for i=1:conditionN
	conditionsSummary{i+1,1} = i;
	conditionsSummary{i+1,2} = resultsLocal(i).condition;
	conditionsSummary{i+1,3} = resultsLocal(i).normCondition;
	
	fullConditionNames(i) = strcat({resultsLocal(i).condition},{' norm '},...
		{resultsLocal(i).normCondition});
end

disp(conditionsSummary)

%% DELETE UNNECESSARY CONDITIONS

[idxToDelete,~]= listdlg('ListString',fullConditionNames...
	,'Name','Select conditions to delete'...
	,'ListSize',[300 300]...
	,'PromptString','Use CTRL or CMD to select multiple conditions.');

structsToKeep = true([1 length(resultsLocal)]);
if ~isempty(idxToDelete)
	for i=1:length(idxToDelete)
		structsToKeep(idxToDelete(i)) = false;
	end
end

resultsLocal = resultsLocal(structsToKeep);
conditionN = length(resultsLocal);

%% OUTPUT TO EXCEL

outputResultsLocalToExcel(resultsLocal,saveLocalResultsFolder)

%% DESCRIPTIVES (each cell as sample)

for i=1:length(resultsLocal)																								% for all conditions
	meanMemDens			= mean(resultsLocal(i).logMemDens);										% mean log rho
	C(:,i)					= 10.^meanMemDens;																				% back transformed mean per condition
end

 cond_MemDens_cellN			= cell(length(resultsLocal),1);
 normCond_MemDens_cellN	= cell(length(resultsLocal),1);
 mean_MemDens_cellN			= cell(length(resultsLocal),1);
 median_MemDens_cellN		= cell(length(resultsLocal),1);
 CI_LL_MemDens_cellN		= cell(length(resultsLocal),1);
 CI_UL_MemDens_cellN		= cell(length(resultsLocal),1);
 N_MemDens_cellN				= cell(length(resultsLocal),1);
for i=1:length(resultsLocal)			
	x					= resultsLocal(i).logMemDens;									% log transformed rho CFTR membrane
	SEM				= std(x)/sqrt(length(x));											% Standard Error (after log transform)
	ts				= tinv([0.025  0.975],length(x)-1);						% T-Score (for 95% Confidence Interval)									
	cond_MemDens_cellN{i,:}			= resultsLocal(i).condition;
	normCond_MemDens_cellN{i,:} = resultsLocal(i).normCondition;
	mean_MemDens_cellN{i,:}			= 10^mean(x);
	median_MemDens_cellN{i,:}		= 10^median(x);
	CI_LL_MemDens_cellN{i,:}		= 10.^(mean(x) + ts(1)*SEM); % 95% Confidence Interval 
	CI_UL_MemDens_cellN{i,:}		= 10.^(mean(x) + ts(2)*SEM);	
	N_MemDens_cellN{i,:}				= length(x);
end

titles      = {'condition', 'normalized to', 'N', 'mean rho',...
								'lower CI', 'upper CI', 'median rho'};
results			=	horzcat(cond_MemDens_cellN,normCond_MemDens_cellN,...
							N_MemDens_cellN,mean_MemDens_cellN,...
						  CI_LL_MemDens_cellN,CI_UL_MemDens_cellN, median_MemDens_cellN);
vertcat			 (titles,results)


%% STATISTICS (each cell as sample)

close all
cellN       = sum(vertcat(resultsLocal.localCellN));
statsData   = zeros(cellN,1);
group       = cell(cellN,1);
cellCount   = 1;
for i=1:length(resultsLocal) % for each condition
	res = resultsLocal(i);
	statsData_cell(cellCount:(cellCount+res.localCellN-1)) = res.logMemDens;
	group(cellCount:(cellCount+res.localCellN-1))					 = strcat({res.condition},{' norm '},{res.normCondition});
	cellCount																							 = cellCount + res.localCellN;
end

[p,tbl,stats]		= anova1(statsData_cell, group); % on the log transformed normalised data
[c,m,~,gnames]	= multcompare(stats,'CType','dunn-sidak'); % multiple comparisons between all groups with bonferroni correction
c_titles				= cellstr(char('g1', 'g2', 'LL mean dif CI', 'mean dif(g1-g2)',...
									'UL mean dif CI','P-value'))';
vertcat					(c_titles,num2cell(c))

% [p,stats] = vartestn(statsData_cell',group) 
% [p,stats] = vartestn(10.^statsData_cell',group) 

%% DESCRIPTIVES (each experiment as sample)

totalCellN = sum(vertcat(resultsLocal.localCellN));
data_expN = cell(totalCellN,3);
cellIdx = 0;
for j=1:length(resultsLocal)
	cellN = resultsLocal(j).localCellN;
	for i=1:cellN
		data_expN(cellIdx+i,1) = strcat({resultsLocal(j).condition},{' norm '},...
												{resultsLocal(j).normCondition});										% full condition
		data_expN(cellIdx+i,2) = resultsLocal(j).cellLocation(i,1);							% experiment str
		data_expN{cellIdx+i,3} = resultsLocal(j).logMemDens(i);									% logMemDens
	end
	cellIdx = cellIdx + cellN;
end

[G,conditionGroups,expGroups]	=	findgroups(data_expN(:,1),data_expN(:,2));
stats_meanMemDens	= splitapply(@mean,vertcat(data_expN{:,3}),G);
meanMemDens	= splitapply(@mean,vertcat(data_expN{:,3}),G);
meanMemDens = 10.^meanMemDens;
[condG,conditionNames] = findgroups(conditionGroups);
[expG,expNames] = findgroups(expGroups);
conditionN = length(conditionNames);
expN = length(expNames);

fullCond_MemDens_expN	= conditionNames;
mean_MemDens_expN			= splitapply(@mean,meanMemDens,condG);
median_MemDens_expN		= splitapply(@median,meanMemDens,condG);
STDEV_MemDens_expN		= splitapply(@std,meanMemDens,condG);
N_MemDens_expN				= splitapply(@length,meanMemDens,condG);
sem_MemDens_expN			= STDEV_MemDens_expN ./ sqrt(N_MemDens_expN);
ts										= tinv([0.025  0.975],expN-1);
CI_LL_MemDens_expN		= mean_MemDens_expN + ts(1)*sem_MemDens_expN;
CI_UL_MemDens_expN		= mean_MemDens_expN + ts(2)*sem_MemDens_expN;

titles      = {'condition', 'N', 'mean rho','STDEV rho', 'SEM rho',...
							'lower CI','upper CI', 'median rho'};
results			=	horzcat(fullCond_MemDens_expN,num2cell(N_MemDens_expN),...
							num2cell(mean_MemDens_expN),num2cell(STDEV_MemDens_expN),...
							num2cell(sem_MemDens_expN),num2cell(CI_LL_MemDens_expN),...
							num2cell(CI_UL_MemDens_expN),num2cell(median_MemDens_expN));
vertcat			 (titles,results)


%% STATISTICS (each experiment as sample)
close all

[~,tbl,stats]		= anova1(stats_meanMemDens, conditionGroups);
[c,m,~,gnames]  = multcompare(stats,'CType','dunn-sidak');
c_titles	= {'g1', 'g2', 'LL mean dif CI', 'mean dif(g1-g2)',...
						'UL mean dif CI','P-value'};
vertcat			(c_titles,num2cell(c))

% construct B
B = NaN(expN,conditionN);
for k=1:length(meanMemDens)
	B(expG(k),condG(k)) = meanMemDens(k);
end

results = horzcat(expNames,num2cell(B));
titles = horzcat(cell(1,1),conditionNames');

vertcat(titles,results)

% results = horzcat(conditionGroups,expGroups,num2cell(meanMemDens));
% titles	= {'full condition','experiment name','mean membrane density'};
% 
% vertcat(titles,results)


%% STATISTICS T-test (each experiment as sample)
[indx,tf]				= listdlg('ListString',gnames,'Name',...
								'select two groups for T-test','ListSize',[300 300]);
[~,p,ci,stats]	= ttest(log10(B(:,indx(1))),log10(B(:,indx(2)))); %

fprintf('p value for comparison = %.5f\n',p)

%% QQ-PLOTS & FREQUENCY DISTRIBUTIONS (each cell as sample)
figure;
for b  = 1:length(resultsLocal)
	MembraneDensity = resultsLocal(b).logMemDens;
	subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),b);
		qqplot(MembraneDensity);
		yLab = ylabel(sprintf('log Rho_{YFP,membrane}\nQuantiles'));
		set(yLab,'fontsize',9)
		xLab = xlabel(sprintf('Standard Normal Quantiles'));
		set(xLab,'fontsize',8)
		titleStr = strcat({resultsLocal(b).condition},{'\nnorm '},{resultsLocal(b).normCondition});
		title(sprintf(titleStr{1}));
end

figure;
for b  = 1:length(resultsLocal)
	MembraneDensity = resultsLocal(b).memDens;
	subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),b);
		qqplot(MembraneDensity);
		yLab = ylabel(sprintf('Rho_{CFTR membrane}\nQuantiles'));
		set(yLab,'fontsize',9)
		xLab = xlabel(sprintf('Standard Normal Quantiles'));
		set(xLab,'fontsize',8)
		titleStr = strcat({resultsLocal(b).condition},{'\nnorm '},{resultsLocal(b).normCondition});
		title(sprintf(titleStr{1}));
end

figure;

for b  = 1:length(resultsLocal)
	MembraneDensity = resultsLocal(b).logMemDens;
	subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),b);
		histogram(MembraneDensity,30,'BinLimits',[-2,1],'Orientation', 'vertical');
		xLab = xlabel('log10 Rho_{CFTR membrane}');
		set(xLab,'fontsize',9)
		yLab = ylabel('Frequency');
		set(yLab,'fontsize',8)
		titleStr = strcat({resultsLocal(b).condition},{'\nnorm '},{resultsLocal(b).normCondition});
		title(sprintf(titleStr{1}));
end

figure;

for b  = 1:length(resultsLocal)
	MembraneDensity = resultsLocal(b).memDens;
	subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),b);
		histogram(MembraneDensity,30,'BinLimits',[0,6],'Orientation', 'vertical');
		xLab = xlabel('Rho_{CFTR membrane}');
		set(xLab,'fontsize',9)
		yLab = ylabel('Frequency');
		set(yLab,'fontsize',8)
		titleStr = strcat({resultsLocal(b).condition},{'\nnorm '},{resultsLocal(b).normCondition});
		title(sprintf(titleStr{1}));
end

%% CORRELATION PLOTS

close all
for i=1:length(resultsLocal)
  subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),i);
	plotLocalRedYelCorr(resultsLocal(i),'entire');
	hold on
end


%% IMAGE DISPLAY with all selected cells boxed
close all

x=1; % plate number
y=1; % image number

fprintf('\nImage %d in exp %d has %d cells.\n'...
	,y,x,plate(x).image(y).cellN(end))

BB = zeros(plate(x).image(y).cellN(end),4);
for ii= 1:plate(x).image(y).cellN(end)
	BB(ii,:)=plate(x).image(y).boundingBox(ii,:);
end

figure
redAxes		= localDisplayImage(plate(x).image(y),'red');
redAxes		= localAddRectangleToImage(redAxes,BB);
redFrame	= getframe(redAxes);
imwrite(redFrame.cdata,'image.jpg')

% localDisplayImage(exp(x).imageLocal(y),'yel')
% figure
% localDisplayImage(exp(x).imageLocal(y),'blend')

%% CELL DISPLAY
% close all
x=1; % plate index
y=1; % image index
z=1:3; % cell index

fprintf('\nImage %d in exp %d has %d cells.\n',y,x,plate(x).image(y).cellN(end))

for i=z
	figure('position',[400 400 500 600])
	subplot(3,3,1)
	cellDisplay(plate(x).image(y),'red',i)
	subplot(3,3,2)
	cellDisplay(plate(x).image(y),'yel',i)
	subplot(3,3,3)
	cellDisplay(plate(x).image(y),'bw',i)
	subplot(3,1,[2,3])
	plotFOverDistance(plate(x).image(y),i)
end


%% OUTPUT CELLS TO FILE

if isToolboxAvailable('Computer Vision System Toolbox','error')
	tic;
	saveLocation			= fullfile('~','Desktop','resultsLocal','example_cells');
	fprintf						('Saving cell images...\n')
	labelAndSaveCells (resultsLocal,plate,saveLocation)
	fprintf						('Done\n')
	toc
end
