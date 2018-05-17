function plotMaxGradBarChart( resultsStructArray )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
colors          = get(groot,'DefaultAxesColorOrder');
conditionN      = length(resultsStructArray);

        % maxGrad         = zeros(1,2.*conditionN)  ;  
        % errorGrad       = zeros(1,2.*conditionN)  ;
        % for ii = 1:2:conditionN*2
        % 	res              = resultsStructArray(ii*.5+.5);
        % 	maxGrad(1,ii)    = mean(res.maxGradTest);    % FORSKOLIN
        % 	maxGrad(1,ii+1)  = mean(res.maxGradControl); % DMSO 
        % 	errorGrad(1,ii)  = std(res.maxGradTest);
        % 	errorGrad(1,ii+1)= std(res.maxGradControl);
        % end
        
maxGrad     = zeros(2,conditionN);
errorGrad   = zeros(2,conditionN);

for i = 1:conditionN
	res = resultsStructArray(i);
	maxGrad(1,i) = mean(res.maxGradTest);
	maxGrad(2,i) = mean(res.maxGradControl);
	errorGrad(1,i) = std(res.maxGradTest);
	errorGrad(2,i) = std(res.maxGradControl);
end
maxGrad     = maxGrad';
errorGrad   = errorGrad';

bar
% x = 1:5;
% y = maxGrad;
% e = errorGrad;
% h = errorbar(y,e, 'o-');
% set(h, 'MarkerSize', 5, );
% xticklength = length(get(gca,'Xticklabel'));
% set(gca,'XtickLabel',{'' '9' '' '15' ''})
% 
errorbar	(maxGrad,errorGrad,'*')
xlabel		('condtions')
% conditions = cell(1,conditionN);
% for i = 1:conditionN
%     conditions(i) = cellstr(resultsStructArray(i).mutation);
% end
% 
% 
% bar_width=0.9;
% % init group width and bar shift
% shift_span=(1-bar_width)*(N_grps-1);
% bar_shift=linspace(-shift_span/2,+shift_span/2,N_grps);
% 
% % compute position of group x ticks
% bar_xtick=N_grps/2+0.5:N_grps:N_bars*N_grps-N_grps/2+0.5;
% [N_grps,N_bars]     =   size(maxGrad);
% % plot the bars themselves
% for grp=1:N_grps
%     hb(grp)=bar( ...
%         (grp:N_grps:N_bars*N_grps-(N_grps-grp))-bar_shift(grp), ... % this is the x position for each bar
%         bar_input(grp,:),  ... % this is the y position for each bar
%         bar_width/N_grps, ... % this is the width of each bar
%         'FaceColor',bar_colors(grp,:), ... % color parameter
%         optional_bar_arguments{:}); % extra parameters
% end
% 
% % plot the error bars
% if any(any(errorbar_lower~=0))||any(any(errorbar_upper~=0))
%     
%     for grp=1:N_grps
%         he(grp)=errorbar( ...
%             (grp:N_grps:N_bars*N_grps-(N_grps-grp))-bar_shift(grp), ... % this is the x position for each bar
%             bar_input(grp,:),  ... % this is the y position for each bar
%             errorbar_lower(grp,:), ... % this is the error low value for each bar
%             errorbar_upper(grp,:), ... % this is the error high value for each bar
%             'Color',errorbar_colors(grp,:), ... % color parameter
%             optional_errorbar_arguments{:}); % extra parameters
%     end
% 
% 
% 
% figure
% b = errorbar_groups         (maxGrad',errorGrad');
% hold on
% xticks          (1:1:10)
% set             (gca, 'Ticklength', [0 0])
% set             (gca,'xticklabel',conditions)
% xtickangle      (90)
% ylabel          ('Mean max. d [I^-] / dt  (mM s^{-1})')
% ylim            ([0 max(max(maxGrad)).*1.15])
% xlim            ([0 length(conditions).*1.1])
% set             (gca,'fontsize',10)
% %errorbar        (1:conditionN,maxGrad,errorGrad,'.k')
% legend          ('WT','F508del','F508del/R1070W','location','northeast')
% b(1).FaceColor = colors(2,:);
% b(2).FaceColor = colors(6,:);
% b(3).FaceColor = colors(4,:);
end

