 
%2 divide into different groups
clc
clear

load('Num.mat');

threshold=10;
group=cutpart(threshold,Num);

search_threshold=0.6;
ad_stay_time=2;

load('data.mat');
load('sample.mat');

[result time]=readgroup(group,ad_var,ad_smaple_var,search_threshold,p,ad_stay_time);

for i=1:length(target)
    ad_time_cum(i)=sum(time(:,i));
end

hold on
stem(ad_time_cum) 
set(gca,'FontSize',100)
xlabel('Advertising number');
ylabel('Time(s)')
hold off
%set(gca,'xticklabel',target)