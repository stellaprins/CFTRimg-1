
% close all other windows
close all
imtool close all

% add the functions to the path
addpath(genpath('functions'));

%% CREATE DATA STRUCTURES OPTION 1

conditionsStr = {'WT','CF'};

conds = createConditions(conditionsStr);

% set the wells for each condition
conds(1).wells = {'B05','B06'};
conds(2).wells = {'B07','B08'};

conditionsN = length(conds);

%% IMPORT THE DATA

experiment = 'exp1';

% Set the directory in which data is stored
directory = strcat('~/Desktop/data/',experiment,'/');

% automatically create the filenames for importing
% how many sites how been collected per well
sitesN = 9;
sites = cell(1,9);
for i=1:sitesN
   sites(i) = {strcat('s',num2str(i))};
end

for i=1:conditionsN
	for j=1:length(conds(i).wells)
		for k=1:sitesN
			
			conds(i).redFiles((j-1)*sitesN + k) = ...
				strcat(directory,experiment,'_',conds(i).wells(j),'_',sites(k),'_w2.TIF');
			conds(i).yelFiles((j-1)*sitesN + k) = ...
				strcat(directory,experiment,'_',conds(i).wells(j),'_',sites(k),'_w1.TIF');
			
			conds(i).redImages((j-1)*sitesN + k) = ...
				{imread(conds(i).redFiles{(j-1)*sitesN+k})};
			conds(i).yelImages((j-1)*sitesN + k) = ...
				{imread(conds(i).yelFiles{(j-1)*sitesN+k})};
		
		end
	end
end

%% PROCESSING



%% RESULTS