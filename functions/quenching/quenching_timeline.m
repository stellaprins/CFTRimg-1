function [results] = quenching_timeline (conditionStruct)
yelN            = 70;
testN			= conditionStruct.quenchImageTestN;
controlN        = conditionStruct.quenchImageControlN;
yelTest			= zeros(yelN,testN);
yelControl		= zeros(yelN,testN);
countTest		= 1;
countControl    = 1;

% test=forskolin, control=dmso
for i = 1:(testN+controlN)
	if      strcmp(conditionStruct.imageQuench(i).test_control,'test')
            yelTest(:,countTest)        = conditionStruct.imageQuench(i).yelInsideOverT;
            countTest                   = countTest + 1;
    elseif  strcmp(conditionStruct.imageQuench(i).test_control,'control')
            yelControl(:,countControl)  = conditionStruct.imageQuench(i).yelInsideOverT;
            countControl                = countControl + 1;
    end
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
    for i = 2:length(mean_iodine_conc_DMSO-1)
        change_iodine_conc_DMSO(i,j) = ...
       (mean_iodine_conc_DMSO(i,j) - ...
        mean_iodine_conc_DMSO(i-1,j))/2; % mM s^(-1)
    end
end

change_iodine_conc_F_mean = zeros(length(change_iodine_conc_F),1);
change_iodine_conc_F_std  = zeros(length(change_iodine_conc_F),1);

for j = 1:length(change_iodine_conc_F);
    change_iodine_conc_F_mean(j) = mean(change_iodine_conc_F(j,:));
    change_iodine_conc_F_std(j)  = std(change_iodine_conc_F(j,:));
end

change_iodine_conc_DMSO_mean = zeros(length(change_iodine_conc_DMSO),1);
change_iodine_conc_DMSO_std  = zeros(length(change_iodine_conc_DMSO),1);

for j = 1:length(change_iodine_conc_DMSO);
    change_iodine_conc_DMSO_mean(j) = mean(change_iodine_conc_DMSO(j,:));
    change_iodine_conc_DMSO_std(j)  = std(change_iodine_conc_DMSO(j,:));
end

% TIMELINE NORMALISED FLUORESCENCE INTENSITY 
per_well_F          =   vertcat((horzcat(cellstr('Fluorescence intensity per well (F)')))...
                        ,num2cell([yelTest]'));
rate_well_F         =    vertcat((horzcat(cellstr('Rate of iodine entry per well (F)')))...
                        ,num2cell([change_iodine_conc_F]'));
per_cond_F          =   vertcat((horzcat(cellstr('Average fluorescence intensity (F)')))...
                        ,num2cell([meanYelTest]'));
rate_cond_F         =    vertcat((horzcat(cellstr('Average rate of iodine entry (F)')))...
                        ,num2cell([change_iodine_conc_F]'));
std_per_well_F      =   vertcat((horzcat(cellstr('std')))...
                        ,num2cell([errYelTest]')); 
                    
per_well_DMSO       =   vertcat((horzcat(cellstr('Fluorescence intensity per well  (DMSO)')))...
                        ,num2cell([yelControl]'));
per_cond_DMSO       =   vertcat((horzcat(cellstr('Average fluorescence intensity (DMSO)')))...
                        ,num2cell([meanYelControl]'));
std_per_cond_DMSO   =   vertcat((horzcat(cellstr('std')))...
                        ,num2cell([errYelControl]')); 
          
horzcat     (condition_quench,N_quench,max_rate_F,max_rate_F_tp,...
             N_quench_DMSO,max_rate_DMSO,max_rate_DMSO_tp)
xlswrite    ([saveQuenchResultsHere],...
            [condition_quench,N_quench,max_rate_F,max_rate_F_tp,...
            N_quench_DMSO,max_rate_DMSO,max_rate_DMSO_tp]);
        
        