%% RESULTS SUMMARY

saveLocalResultsFolder = fullfile('~','Desktop','resultsLocal');
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
B = NaN(length(exp),length(resultsLocal)); 
for i=1:length(resultsLocal)																								% for the number of conditions
	G								=	findgroups(vertcat(resultsLocal(i).cellLocation{:,2}));	% G = different plates
	meanMemDens			= splitapply(@mean,resultsLocal(i).logMemDens,G);					% mean per plate (rows) per condition (colums)
	B(1:length(meanMemDens),i) = 10.^meanMemDens;															% back transformed mean per plate
end
 cond_MemDens_expN			= cell(length(resultsLocal),1);
 normCond_MemDens_expN	= cell(length(resultsLocal),1);
 mean_MemDens_expN			= cell(length(resultsLocal),1);
 median_MemDens_expN		= cell(length(resultsLocal),1);
 CI_LL_MemDens_expN			= cell(length(resultsLocal),1);
 CI_UL_MemDens_expN			= cell(length(resultsLocal),1);
 N_MemDens_expN					= cell(length(resultsLocal),1);
 sem_MemDens_expN				= cell(length(resultsLocal),1);
 STDEV_MemDens_expN			= cell(length(resultsLocal),1);
for i=1:length(resultsLocal)															% for the number of conditions
	x					= B(:,i);																			% Data points
	SEM				= nanstd(x)/sqrt(length(x(~isnan(x))));				% Standard Error
	ts				= tinv([0.025  0.975],length(B(:,i))-1);			% T-Score (for 95% Confidence Interval)				 
	cond_MemDens_expN{i,:}		= resultsLocal(i).condition;
	mean_MemDens_expN{i,:}		= nanmean(x);
	median_MemDens_expN{i,:}	= nanmedian(x);
	sem_MemDens_expN{i,:}			=	SEM;
	CI_LL_MemDens_expN{i,:}		= nanmean(x) + ts(1)*SEM; 				% 95% Confidence Interval
	CI_UL_MemDens_expN{i,:}		= nanmean(x) + ts(2)*SEM; 
	N_MemDens_expN{i,:}				= length(x(~isnan(x)));
	STDEV_MemDens_expN{i,:}		=	nanstd(x);
	normCond_MemDens_expN{i,:} = resultsLocal(i).normCondition;
end

titles      = {'conditions','normalised to', 'N', 'mean rho','STDEV rho', 'SEM rho',...
							'lower CI','upper CI', 'median rho'};
results			=	horzcat(cond_MemDens_expN, 	normCond_MemDens_expN,N_MemDens_expN,...
							mean_MemDens_expN,STDEV_MemDens_expN,...
							sem_MemDens_expN,CI_LL_MemDens_expN,...
							CI_UL_MemDens_expN,median_MemDens_expN);
vertcat			 (titles,results)


%% STATISTICS (each experiment as sample)
close all
statsData_exp				= [];
group_exp						= [];
for i=1:length(resultsLocal)		
	G										=	findgroups(vertcat(resultsLocal(i).cellLocation{:,2}));	% define experiment groups 
	meanMemDens					= splitapply(@mean,resultsLocal(i).logMemDens,G);					% mean log transformed normalised rho per plate (rows) per condition (colums)
	meanMemDens_back   	= 10.^meanMemDens;																				% back transformation
	statsData_exp       = vertcat(statsData_exp,meanMemDens_back);
 	group     					= repmat(strcat({resultsLocal(i).condition},{' norm '},...
												{resultsLocal(i).normCondition}),length(meanMemDens),1);
	group_exp						= vertcat(group_exp,group);
end

[~,tbl,stats]		= anova1(statsData_exp, group_exp);
[c,m,~,gnames]  = multcompare(stats,'CType','dunn-sidak');
c_titles	= {'g1', 'g2', 'LL mean dif CI', 'mean dif(g1-g2)',...
						'UL mean dif CI','P-value'};
vertcat			(c_titles,num2cell(c))

% mean rho per experiment
expNames = cell(length(exp)+1,1);
for i = 1:length(exp)
 expNames(i+1) = {exp(i).expStr};
end
B_group		= vertcat(gnames',num2cell(B));
horzcat		(expNames,B_group)

%% STATISTICS T-test (each experiment as sample)
[indx,tf]				= listdlg('ListString',gnames,'Name',...
								'select two groups for T-test','ListSize',[300 300]);
[~,p,ci,stats]	= ttest(B(:,indx(1)),B(:,indx(2))); %

fprintf('p value for comparison = %.3f\n',p)

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

x=1; % experiment number
y=1; % image number

fprintf('\nImage %d in exp %d has %d cells.\n'...
	,y,x,exp(x).imageLocal(y).cellN(end))

BB = zeros(exp(x).imageLocal(y).cellN(end),4);
for ii= 1:exp(x).imageLocal(y).cellN(end)
	BB(ii,:)=exp(x).imageLocal(y).boundingBox(ii,:);
end

figure
redAxes		= localDisplayImage(exp(x).imageLocal(y),'red');
redAxes		= localAddRectangleToImage(redAxes,BB);
redFrame	= getframe(redAxes);
imwrite(redFrame.cdata,'image.jpg')

% localDisplayImage(exp(x).imageLocal(y),'yel')
% figure
% localDisplayImage(exp(x).imageLocal(y),'blend')

%% CELL DISPLAY
% close all
x=1; % exp index
y=1; % image index
z=1:3; % cell index

fprintf('\nImage %d in exp %d has %d cells.\n',y,x,exp(x).imageLocal(y).cellN(end))

for i=z
	figure('position',[400 400 500 600])
	subplot(3,3,1)
	cellDisplay(exp(x).imageLocal(y),'red',i)
	subplot(3,3,2)
	cellDisplay(exp(x).imageLocal(y),'yel',i)
	subplot(3,3,3)
	cellDisplay(exp(x).imageLocal(y),'bw',i)
	subplot(3,1,[2,3],'position',[0.12 0.1 0.74 0.54])
	plotFOverDistance(exp(x).imageLocal(y),i)
end


%% OUTPUT CELLS TO FILE

tic;
saveLocation			= fullfile('~','Desktop','resultsLocal','example_cells');
fprintf						('Saving cell images...\n')
labelAndSaveCells (resultsLocal,exp,saveLocation)
fprintf						('Done\n')
toc
