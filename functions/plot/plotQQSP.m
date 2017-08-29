   
for b  = 1:length(cond)
    subplot(1,length(cond),b)
    qq = qqplot(resultsLocal(b).yelMembrane./resultsLocal(b).redEntire);
    title(cond(b).mutation)
    hold on
end

