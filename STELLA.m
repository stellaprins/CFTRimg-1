load('plates.mat')
% % % %%
% % % % F508del + VX-809 28
% % %  Fdel_VX_28_1			= resultsLocal(1).YFPMembrane_norm;
% % % % F508del + VX-809 37
% % %  Fdel_VX_37_1			= resultsLocal(2).YFPMembrane_norm;
% % % % F508del 28
% % %  Fdel_28_1				= resultsLocal(3).YFPMembrane_norm;
% % % % F508del 37
% % %  Fdel_37_1				= resultsLocal(4).YFPMembrane_norm;
% % % % WT 28
% % %  WT_28_1					= resultsLocal(5).YFPMembrane_norm;
% % % % WT 37
% % %  WT_37_1					= resultsLocal(6).YFPMembrane_norm;
% % %  
% % %  %%
% % %  save								('./plate1.mat');
 
 %%
 
res(1).MD    				= vertcat(WT_37_1,WT_37_2,WT_37_3,WT_37_4,WT_37_5);
res(1).N						= length(res(1).MD);
res(1).con					= 'WT 37°C';

res(2).MD						= vertcat(WT_28_1,WT_28_2,WT_28_3,WT_28_4,WT_28_5);
res(2).N						= length(res(2).MD);
res(2).con					= 'WT 28°C';

res(3).MD     			= vertcat(Fdel_37_1,Fdel_37_2,Fdel_37_3,Fdel_37_4,Fdel_37_5);
res(3).N						= length(res(3).MD);
res(3).con					= 'F508del 37°C';

res(4).MD						= vertcat(Fdel_28_1,Fdel_28_2,Fdel_28_3,Fdel_28_4,Fdel_28_5);
res(4).N						= length(res(4).MD);
res(4).con					= 'F508del 28°C';

res(5).MD						= vertcat(Fdel_VX_37_1,Fdel_VX_37_2,Fdel_VX_37_3,Fdel_VX_37_4,Fdel_VX_37_5);
res(5).N						= length(res(5).MD);
res(5).con					= 'F508del + VX-809 37°C';

res(6).MD					 	= vertcat(Fdel_VX_28_1,Fdel_VX_28_2,Fdel_VX_28_3,Fdel_VX_28_4,Fdel_VX_28_5);
res(6).N						= length(res(6).MD);
res(6).con					= 'F508del + VX-809 28°C';

 
Ntotal							= res(1).N+res(2).N+res(3).N+res(4).N+res(5).N+res(6).N;

 %% MEAN 
 
Fdel_28_m			= mean(Fdel_28);
Fdel_37_m			= mean(Fdel_37);
WT_37_m				= mean(WT_37);
WT_28_m				= mean(WT_28);
Fdel_VX_28_m	= mean(Fdel_VX_28);
Fdel_VX_37_m 	= mean(Fdel_VX_37);

Fdel_28_sd     = std(Fdel_28);
Fdel_37_sd     = std(Fdel_37);
WT_37_sd       = std(WT_37);
WT_28_sd       = std(WT_28);
Fdel_VX_28_sd  = std(Fdel_VX_28);
Fdel_VX_37_sd  = std(Fdel_VX_37);

mean = vertcat(WT_37_m,WT_28_m,Fdel_37_m,Fdel_28_m,Fdel_VX_37_m,Fdel_VX_28_m);
sd   = vertcat(WT_37_sd,WT_28_sd,Fdel_37_sd,Fdel_28_sd,Fdel_VX_37_sd,Fdel_VX_28_sd);


%% STATISTICS
close all

cellN       = Ntotal;
statsData   = zeros(cellN,1);
group       = cell(cellN,1);
cellCount   = 1;

for i=1:6
	r = res(i);
	statsData(cellCount:(cellCount+r.N-1)) = r.MD;
	group(cellCount:(cellCount+r.N-1)) = {r.con};
	cellCount = cellCount + r.N;
end

[pKruskalWallis, statsKW] = plotKruskalWallis(statsData,group);
figure;
[c,m,~,gnames] = multcompare(statsKW,'CType','dunn-sidak');

