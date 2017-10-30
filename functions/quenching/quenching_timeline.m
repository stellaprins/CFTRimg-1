function [results] = quenching_timeline (resultsStruct)
yelN          = 70;
testN					= length(resultsStruct.maxGradTest);
controlN      = length(resultsStruct.maxGradControl);
yelTest				= zeros(yelN,testN);
yelControl		= zeros(yelN,testN);
countTest			= 1;
countControl	= 1;

% test=forskolin, control=dmso
for i=1:testN
   yelTest(:,countTest) = resultsStruct.yelInsideOverTTest(i,:);
   countTest            = countTest + 1;
end

for i=1:controlN
	yelControl(:,countControl)	= resultsStruct.yelInsideOverTControl(i,:);
	countControl                = countControl + 1;
end
	
yelControl( :, all(~yelControl,1) )     = []; %remove all columns with only zeros
yelTest( :, all(~yelControl,1) )        = []; %remove all columns with only zeros
iodine_conc_F           = 1.9 * ((1-yelTest)./yelTest);         % mM
iodine_conc_DMSO        = 1.9 * ((1-yelControl)./yelControl);   % mM
meanYelTest             = mean((yelTest),2);
meanYelControl          = mean((yelControl),2);
errYelTest              = std((yelTest),0,2);
errYelControl           = std((yelControl),0,2);
mean_iodine_conc_F      = 1.9 * ((1-meanYelTest)./meanYelTest);         % mM
mean_iodine_conc_DMSO   = 1.9 * ((1-meanYelControl)./meanYelControl);   % mM

% RATE OF IODINE ENTRY
change_iodine_conc_F    = zeros(length(mean_iodine_conc_F),testN);
change_iodine_conc_DMSO = zeros(length(mean_iodine_conc_DMSO),controlN);

for j = 1:testN
    for i = 2:length(iodine_conc_F)
        change_iodine_conc_F(i,j) = ...
        (iodine_conc_F(i,j)- ...
         iodine_conc_F(i-1,j))/2; % mM s^(-1)
    end
end

for j = 1:controlN
    for i = 2:length(mean_iodine_conc_DMSO)
        change_iodine_conc_DMSO(i,j) = ...
       (iodine_conc_DMSO(i,j) - ...
        iodine_conc_DMSO(i-1,j))/2; % mM s^(-1)
    end
end

change_iodine_conc_F_mean = zeros(length(change_iodine_conc_F),1);
change_iodine_conc_F_std  = zeros(length(change_iodine_conc_F),1);

for j = 1:length(change_iodine_conc_F)
    change_iodine_conc_F_mean(j) = mean(change_iodine_conc_F(j,:));
    change_iodine_conc_F_std(j)  = std(change_iodine_conc_F(j,:));
end

change_iodine_conc_DMSO_mean = zeros(length(change_iodine_conc_DMSO),1);
change_iodine_conc_DMSO_std  = zeros(length(change_iodine_conc_DMSO),1);

for j = 1:length(change_iodine_conc_DMSO)
    change_iodine_conc_DMSO_mean(j) = mean(change_iodine_conc_DMSO(j,:));
    change_iodine_conc_DMSO_std(j)  = std(change_iodine_conc_DMSO(j,:));
end

% TIMELINE NORMALISED FLUORESCENCE INTENSITY 
header_F            =   cell(1,testN);
header_F(1)         =   cellstr('Fluorescence intensity per well (F)');
per_well_F          =   vertcat(header_F, num2cell([yelTest]));
header_F(1)         =   cellstr('Rate of iodine entry per well (F)');
rate_well_F         =   vertcat(header_F, num2cell([change_iodine_conc_F]));
per_cond_F          =   vertcat(cellstr('Average fluorescence intensity (F)')...
                        ,num2cell([meanYelTest]));          
rate_cond_F         =    vertcat(cellstr('Average rate of iodine entry (F)')...
                        ,num2cell([change_iodine_conc_F_mean]));
rate_cond_F_std     =    vertcat(cellstr('std')...
                        ,num2cell([change_iodine_conc_F_std]));           
std_per_cond_F      =   vertcat(cellstr('std'),num2cell([errYelTest]));    

header_DMSO         =   cell(1,controlN);
header_DMSO(1)      =   cellstr('Fluorescence intensity per well (DMSO)');
per_well_DMSO       =   vertcat(header_DMSO, num2cell([yelControl]));
header_DMSO(1)      =   cellstr('Rate of iodine entry per well (DMSO)');
rate_well_DMSO      =   vertcat(header_DMSO, num2cell([change_iodine_conc_DMSO]));
per_cond_DMSO       =   vertcat(cellstr('Average fluorescence intensity (DMSO)')...
                        ,num2cell([meanYelControl]));
rate_cond_DMSO      =    vertcat(cellstr('Average rate of iodine entry (DMSO)')...
                        ,num2cell([change_iodine_conc_DMSO_mean]));             
std_per_cond_DMSO   =   vertcat(cellstr('std'),num2cell([errYelControl])); 
rate_cond_DMSO_std  =    vertcat(cellstr('std')...
                        ,num2cell([change_iodine_conc_DMSO_std]));                
                 
count_F             = testN;
count_DMSO          = controlN;
count_col           = count_F*2+count_DMSO*2+8;
header_condition    = cell(1,count_col);
header_condition(1) = cellstr(resultsStruct.mutation);

results_F           =   horzcat(per_well_F, per_cond_F,std_per_cond_F,...
                        rate_well_F, rate_cond_F, rate_cond_F_std);
results_DMSO        =   horzcat(per_well_DMSO, per_cond_DMSO,std_per_cond_DMSO,...
                        rate_well_DMSO, rate_cond_DMSO, rate_cond_DMSO_std);
results             =   horzcat(results_F,results_DMSO) ;      
results             =   vertcat(header_condition, results);
        