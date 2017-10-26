function [ results ] = combineResults( res1,res2,res3,res4,res5 )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

conditionN = length(res1);
resultsTemplate = struct(...
			'mutation',[]...
			,'yelEntire',[]...
			,'yelMembrane',[]...
			,'redEntire',[]...
			,'localCellN',[]);
		
for i=1:conditionN
	results(i) = resultsTemplate;
end

for i=1:conditionN
	
	results(i).mutation = res1(i).mutation;
	results(i).yelEntire = vertcat(res1(i).yelEntire,res2(i).yelEntire...
		,res3(i).yelEntire,res4(i).yelEntire,res5(i).yelEntire);
	results(i).yelMembrane = vertcat(res1(i).yelMembrane,res2(i).yelMembrane...
		,res3(i).yelMembrane,res4(i).yelMembrane,res5(i).yelMembrane);
	results(i).redEntire = vertcat(res1(i).redEntire,res2(i).redEntire...
		,res3(i).redEntire,res4(i).redEntire,res5(i).redEntire);
	results(i).localCellN = sum([res1(i).localCellN,res2(i).localCellN...
		,res3(i).localCellN,res4(i).localCellN,res5(i).localCellN]);
end


end

