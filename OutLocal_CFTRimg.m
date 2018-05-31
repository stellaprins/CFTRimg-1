

saveLocalResultsHere  ='C:\Users\StellaPrins\Desktop\xx';

conditionN						= length(resultsLocal);

%% DESCRIPTIVES (each cell as sample)

for i=1:length(resultsLocal)																								% for all conditions
	meanMemDens			= mean(resultsLocal(i).logNormMemDens);										% mean log rho
	C(:,i)					= 10.^meanMemDens;																				% back transformed mean per condition
end
for i=1:length(resultsLocal)			
	x					= resultsLocal(i).logNormMemDens;							% log transformed rho CFTR membrane
	SEM				= std(x)/sqrt(length(x));											% Standard Error (after log transform)
	ts				= tinv([0.025  0.975],length(x)-1);						% T-Score (for 95% Confidence Interval)									
	cond_MemDens_cellN(i,:)		= cellstr(resultsLocal(i).mutation);
	mean_MemDens_cellN(i,:)		= 10^mean(x);
	median_MemDens_cellN(i,:)	= 10^median(x);
	CI_MemDens_cellN(i,:)			= 10.^(mean(x) + ts*SEM);			% 95% Confidence Interval 
	N_MemDens_cellN(i,:)			= length(x);
end

titles      = cellstr(char('conditions', 'N', 'mean rho','lower CI','upper CI', 'median rho'))';
results			=	horzcat(cond_MemDens_cellN,num2cell(N_MemDens_cellN),...
							num2cell(mean_MemDens_cellN), num2cell(CI_MemDens_cellN), ...
							num2cell(median_MemDens_cellN));
vertcat			 (titles,results)
% if ispc == true
% 	xlswrite(saveLocalResultsHere,results)
% elseif isunix==true
% 	outputResultsLocalToExcelMAC(resultsLocal,saveLocalResultsHere)
% end

%% STATISTICS (each cell as sample)

close all
cellN       = sum(vertcat(resultsLocal.localCellN));
statsData   = zeros(cellN,1);
group       = cell(cellN,1);
cellCount   = 1;
for i=1:length(resultsLocal) % for each condition
	res = resultsLocal(i);
	statsData_cell(cellCount:(cellCount+res.localCellN-1)) = res.logNormMemDens;
	group(cellCount:(cellCount+res.localCellN-1))					 = {res.mutation};
	cellCount																							 = cellCount + res.localCellN;
end

[p,tbl,stats]		= anova1(statsData_cell, group); % on the log transformed normalised data
[c,m,~,gnames]	= multcompare(stats,'CType','bonferroni'); % multiple comparisons between all groups with bonferroni correction
c_titles	= cellstr(char('g1', 'g2', 'LL mean dif CI', 'mean dif(g1-g2)',...
						'UL mean dif CI','P-value'))';
vertcat			(c_titles,num2cell(c))

% [p,stats] = vartestn(statsData_cell',group) 
% [p,stats] = vartestn(10.^statsData_cell',group) 

%% DESCRIPTIVES (each experiment as sample)
B = NaN(length(plate),length(resultsLocal)); 
for i=1:length(resultsLocal)																								% for the number of conditions
	G								=	findgroups(resultsLocal(i).cellLocation(:,1));					% G = different plates
	meanMemDens			= splitapply(@mean,resultsLocal(i).logNormMemDens,G);			% mean per plate (rows) per condition (colums)
	B(1:length(meanMemDens),i) = 10.^meanMemDens;																				% back transformed mean per plate
end

for i=1%:length(resultsLocal)															% for the number of conditions
	x					= B(:,i);																			% Data points
	SEM				= nanstd(x)/sqrt(length(x(~isnan(x))));											% Standard Error
	ts				= tinv([0.025  0.975],length(B(:,i))-1);			% T-Score (for 95% Confidence Interval)				 
	cond_MemDens_plateN(i,:)		= cellstr(resultsLocal(i).mutation);
	mean_MemDens_plateN(i,:)		= nanmean(x);
	median_MemDens_plateN(i,:)	= nanmedian(x);
	sem_MemDens_plateN(i,:)			= SEM;
	CI_MemDens_plateN(i,:)			= nanmean(x) + ts*SEM; 				% 95% Confidence Interval
	N_MemDens_plateN(i,:)				= length(x(~isnan(x)));
	STDEV_MemDens_plateN(i,:)		= nanstd(x);
end

titles      = cellstr(char('conditions', 'N', 'mean rho','STDEV rho', 'SEM rho',...
							'lower CI','upper CI', 'median rho'))';
results			=	horzcat(cond_MemDens_plateN,num2cell(N_MemDens_plateN),...
							num2cell(mean_MemDens_plateN),num2cell(STDEV_MemDens_plateN),...
							num2cell(sem_MemDens_plateN),...
							num2cell(CI_MemDens_plateN), num2cell(median_MemDens_plateN));
vertcat(titles,results)


%% STATISTICS (each experiment as sample)

close all
statsData_exp				= [];
group_exp						= [];
for i=1:length(resultsLocal)																										% for each condition
	G										=	findgroups(resultsLocal(i).cellLocation(:,1));					% define experiment groups 
	meanMemDens					= splitapply(@mean,resultsLocal(i).logNormMemDens,G);			% mean log transformed normalised rho per plate (rows) per condition (colums)
	meanMemDens_back   	= 10.^meanMemDens;																				% back transformation
	statsData_exp       = vertcat(statsData_exp,meanMemDens_back);
 	group     					= repmat({resultsLocal(i).mutation},length(meanMemDens),1);
	group_exp						= vertcat(group_exp,group);
end

[p,tbl,stats]		= anova1(statsData_exp, group_exp);
[c,m,~,gnames]  = multcompare(stats,'CType','dunn-sidak');
c_titles	= cellstr(char('g1', 'g2', 'LL mean dif CI', 'mean dif(g1-g2)',...
						'UL mean dif CI','P-value'))';
vertcat			(c_titles,num2cell(c))

%% STATISTICS (each experiment as sample)
[h,p,ci,stats]=ttest(B(:,4),B(:,2)) %
[h,p,ci,stats]=ttest(B(:,3),B(:,1))

%% QQ-PLOTS & FREQUENCY DISTRIBUTIONS (each cell as sample)
figure;
for b  = 1:length(resultsLocal)
	MembraneDensity = resultsLocal(b).logNormMemDens;
	subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),b);
		qqplot(MembraneDensity);
		yLab = ylabel(sprintf('log Rho_{YFP,membrane}\nQuantiles'));
		set(yLab,'fontsize',9)
		xLab = xlabel(sprintf('Standard Normal Quantiles'));
		set(xLab,'fontsize',8)
		title(resultsLocal(b).mutation);
end

figure;
for b  = 1:length(resultsLocal)
	MembraneDensity = resultsLocal(b).normMemDens;
	subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),b);
		qqplot(MembraneDensity);
		yLab = ylabel(sprintf('Rho_{CFTR membrane}\nQuantiles'));
		set(yLab,'fontsize',9)
		xLab = xlabel(sprintf('Standard Normal Quantiles'));
		set(xLab,'fontsize',8)
		title(resultsLocal(b).mutation);
end

figure;

for b  = 1:length(resultsLocal)
	MembraneDensity = resultsLocal(b).logNormMemDens;
	subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),b);
		histogram(MembraneDensity,30,'BinLimits',[-2,1],'Orientation', 'vertical');
		xLab = xlabel('log10 Rho_{CFTR membrane}');
		set(xLab,'fontsize',9)
		yLab = ylabel('Frequency');
		set(yLab,'fontsize',8)
		title(resultsLocal(b).mutation);
end

figure;

for b  = 1:length(resultsLocal)
	MembraneDensity = resultsLocal(b).normMemDens;
	subplot(ceil(sqrt((conditionN/2))),round(sqrt((conditionN*2))),b);
		histogram(MembraneDensity,30,'BinLimits',[0,6],'Orientation', 'vertical');
		xLab = xlabel('Rho_{CFTR membrane}');
		set(xLab,'fontsize',9)
		yLab = ylabel('Frequency');
		set(yLab,'fontsize',8)
		title(resultsLocal(b).mutation);
end

%% CORRELATION PLOTS

close all
% figure
for i=1:length(resultsLocal)

    subplot(1,length(resultsLocal),i)
	plotLocalRedYelCorr(resultsLocal(i),'entire');
	hold on

end

for i=1:length(resultsLocal)
	figure
	plotLocalSizeRhoCorr(resultsLocal(i),plate);
end


%% IMAGE DISPLAY with all selected cells boxed
close all

x=1; % plate number
y=1; % image number

fprintf('\nImage %d on plate %d has %d cells.\n'...
	,y,x,plate(x).imageLocal(y).cellN(end))

BB = zeros(plate(x).imageLocal(y).cellN(end),4);
for ii= 1:plate(x).imageLocal(y).cellN(end)
	BB(ii,:)=plate(x).imageLocal(y).boundingBox(ii,:);
end

figure
redAxes		= localDisplayImage(plate(x).imageLocal(y),'red');
redAxes		= localAddRectangleToImage(redAxes,BB);
redFrame	= getframe(redAxes);
imwrite(redFrame.cdata,'image.jpg')

% localDisplayImage(plate(x).imageLocal(y),'yel')
% figure
% localDisplayImage(plate(x).imageLocal(y),'blend')


%% CELL DISPLAY
% close all
x=1; % plate
y=1; % image number

fprintf('\nImage %d on plate %d has %d cells.\n',y,x,plate(x).imageLocal(y).cellN(end))

for i=1:min([2,plate(x).imageLocal(y).cellN(end)])
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
saveLocation			= '~/Desktop/CFTR/cells/test';
fprintf						('Saving cell images...\n')
labelAndSaveCells (resultsLocal,plate,saveLocation)
fprintf						('Done\n')
toc
