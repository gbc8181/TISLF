% This code is used to find the change point in a univariate continuous time series
% using Pettitt Test.
%
%
% The test here assumed is two-tailed test. The hypothesis are as follow:
%  H (Null Hypothesis): There is no change point in the series
%  H(Alternative Hypothesis): There is a change point in the series
% 
% Input: univariate data series
% Output:
% The output of the answer in row wise respectively,
% loc: location of the change point in the series, index value in
% the data set
% K: Pettitt Test Statistic for two tail test
% pvalue: p-value of the test
%
%Reference: Pohlert, Thorsten. "Non-Parametric Trend Tests and Change-Point Detection." (2016).
% 
function a=pettitt(data)
[m n]=size(data);
for t=2:1:m
    for j=1:1:m
      v(t-1,j)=sign(data(t-1,1)-data(j,1));
      V(t-1)=sum(v(t-1,:));
    end
end
U=cumsum(V);
loc=find(abs(U)==max(abs(U)));
K=max(abs(U));
pvalue=2*exp((-6*K^2)/(m^3+m^2));
a=[loc; K ;pvalue];
return 