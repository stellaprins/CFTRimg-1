%% DESCRIPTIVES (each experiment as sample)
B = NaN(length(plate),length(resultsLocal)); 
STD = NaN(length(plate),length(resultsLocal)); 
LENGTH = NaN(length(plate),length(resultsLocal)); 

for i=1:length(resultsLocal)																								% for the number of conditions
	G								=	findgroups(resultsLocal(i).cellLocation(:,1));					% G = different plates
	meanMemDens			= splitapply(@mean,resultsLocal(i).logNormMemDens,G);			% mean per plate (rows) per condition (colums)
	stdMemDens			= splitapply(@std,resultsLocal(i).logNormMemDens,G);
	lengthMemDens		= splitapply(@length,resultsLocal(i).logNormMemDens,G);
	B(1:length(meanMemDens),i)				= meanMemDens;													% mean per plate(log transformed data
	STD(1:length(stdMemDens),i)				= stdMemDens;														% STD per plate (log transformed data)
	LENGTH(1:length(lengthMemDens),i) = lengthMemDens;												% N of cells per plate
	cond_MemDens_plate(i,:)						= cellstr(resultsLocal(i).mutation);
end

SEM = STD ./ sqrt(LENGTH);

ts_mat = NaN(length(plate),length(resultsLocal));
UL_mat = NaN(length(plate),length(resultsLocal));
LL_mat= NaN(length(plate),length(resultsLocal));
for ii = 1:(size(LENGTH,1)*size(LENGTH,2))
	ts						= tinv([0.975],LENGTH(ii)-1);			% T-Score (for 95% Confidence Interval)	
	ts_mat(ii)		= ts;
	UL_mat(ii)		= 10.^(B(ii)+(ts*SEM(ii)));
	LL_mat(ii)		= 10.^(B(ii)-(ts*SEM(ii)));
end

cond_MemDens_plate
B_back = 10.^B'
UL_mat = UL_mat'
LL_mat = LL_mat'
LENGTH = LENGTH'

RES_plate=[];
platetits=[];
for j = 1:length(plate)	
	RES					= horzcat (LENGTH(:,j),B_back(:,j),LL_mat(:,j),UL_mat(:,j));
	RES_plate		= horzcat(RES_plate,RES);
	RES_titles	= repmat(cellstr(char('N', 'mean Rho', 'LL 95% CI', 'UL 95% CI')),j,1)';
	platetit		= cellstr(plate(j).plateStr);
	platetits		= horzcat(platetits,repmat(cellstr(plate(j).plateStr),1,4));
end

results_plate = vertcat(horzcat(cellstr(''),platetits),...
								horzcat(vertcat(cellstr(''),cond_MemDens_plate),...
								(vertcat(RES_titles,num2cell(RES_plate)))))
							
if ispc == true
	xlswrite('C:\Users\StellaPrins\Desktop\results_plate',results_plate)
elseif isunix==true
	outputResultsLocalToExcelMAC(resultsLocal,saveLocalResultsHere)
end
%%

[h,p,ci,stats]=ttest(B_back(4,:),B_back(2,:))
[h,p,ci,stats]=ttest(B_back(1,:),B_back(3,:))
%%

figure;	
i=[6 4 2];
ii =[5 3 1];
	
	subplot(2,2,1)
	plot(B_back(i,:),'-o','lineWidth',.25)
  xlim([1-.2,length(i)+.2])
 	ylim([0,max(max(B_back(i,:)))+.1])
	xticks(1:length(i))
	xticklabels(cond_MemDens_plate(i))
	xtickangle(30)
	set(gca, 'YScale', 'log')
	
	title('37°C')
	ylabel('Rho_{CFTR membrane}')
	set(gca, 'YScale', 'log')
	subplot(2,2,2)
	plot(B_back(ii,:),'-o','lineWidth',.25)
	xticks(1:length(ii))
	xlim([1-.5,length(ii)+.2])
	ylim([0,max(max(B_back(ii,:)))+.5])
	xticklabels(cond_MemDens_plate(ii))
	xtickangle(30)
	title('28°C')
	ylabel('Rho_{CFTR membrane}')
	set(gca, 'YScale', 'log')
	
	subplot(2,2,3)
	errorbar(nanmean(B_back(i,:)'),nanstd(B_back(i,:)')/sqrt(length((B_back(i,:)'))),'-o','lineWidth',.25)
  xlim([1-.2,length(i)+.2])
 	ylim([0,max(max(B_back(i,:)))+.1])
	xticks(1:length(i))
	xticklabels(cond_MemDens_plate(i))
	xtickangle(30)
	title('37°C')
	ylabel('Rho_{CFTR membrane}')
	set(gca, 'YScale', 'log')
	
	subplot(2,2,4)
	errorbar(mean(B_back(ii,:)'),std(B_back(ii,:)')/sqrt(length((B_back(ii,:)'))),'-o','lineWidth',.25)
	xticks(1:length(ii))
	xlim([1-.5,length(ii)+.2])
	ylim([0,max(max(B_back(ii,:)))+.5])
	xticklabels(cond_MemDens_plate(ii))
	xtickangle(30)
	title('28°C')
	ylabel('Rho_{CFTR membrane}')
set(gca, 'YScale', 'log')

%%

figure;	
  i=[1 2 3];
	semilogy(Results_combined_CH_EH(1:8,i)','-o','lineWidth',.25)
  xlim([1-.2,length(i)+.2])
 	ylim([0,max(max(Results_combined_CH_EH(i,:)))+.1])
	xticks(1:length(i))
	xticklabels(cond_MemDens_plate(i))
	xtickangle(30)
	title('37°C')
	ylabel('Rho_{CFTR membrane}')



%% DESCRIPTIVES (each experiment as sample)


B = NaN(length(plate),length(resultsLocal)); 
STD = NaN(length(plate),length(resultsLocal)); 
LENGTH = NaN(length(plate),length(resultsLocal)); 

for i=1:length(resultsLocal)																								% for the number of conditions
	G								=	findgroups(resultsLocal(i).cellLocation(:,1));					% G = different plates
	meanMemDens			= splitapply(@mean,resultsLocal(i).memDens,G);			% mean per plate (rows) per condition (colums)
	stdMemDens			= splitapply(@std,resultsLocal(i).memDens,G);
	lengthMemDens		= splitapply(@length,resultsLocal(i).memDens,G);
	B(1:length(meanMemDens),i)				= meanMemDens;													% mean per plate(log transformed data
	STD(1:length(stdMemDens),i)				= stdMemDens;														% STD per plate (log transformed data)
	LENGTH(1:length(lengthMemDens),i) = lengthMemDens;												% N of cells per plate
	cond_MemDens_plate(i,:)						= cellstr(resultsLocal(i).mutation);
end

SEM = STD ./ sqrt(LENGTH);

ts_mat = NaN(length(plate),length(resultsLocal));
UL_mat = NaN(length(plate),length(resultsLocal));
LL_mat= NaN(length(plate),length(resultsLocal));
for ii = 1:(size(LENGTH,1)*size(LENGTH,2))
	ts						= tinv([0.975],LENGTH(ii)-1);			% T-Score (for 95% Confidence Interval)	
	ts_mat(ii)		= ts;
	UL_mat(ii)		= 10.^(B(ii)+(ts*SEM(ii)));
	LL_mat(ii)		= 10.^(B(ii)-(ts*SEM(ii)));
end

cond_MemDens_plate
B_back = 10.^B'
UL_mat = UL_mat'
LL_mat = LL_mat'
LENGTH = LENGTH'

RES_plate=[];
platetits=[];
for j = 1:length(plate)	
	RES					= horzcat (LENGTH(:,j),B_back(:,j),LL_mat(:,j),UL_mat(:,j));
	RES_plate		= horzcat(RES_plate,RES);
	RES_titles	= repmat(cellstr(char('N', 'mean Rho', 'LL 95% CI', 'UL 95% CI')),j,1)';
	platetit		= cellstr(plate(j).plateStr);
	platetits		= horzcat(platetits,repmat(cellstr(plate(j).plateStr),1,4));
end

results_plate = vertcat(horzcat(cellstr(''),platetits),...
								horzcat(vertcat(cellstr(''),cond_MemDens_plate),...
								(vertcat(RES_titles,num2cell(RES_plate)))))
