load('twoh.mat');
d2=[];

for j=1:200
    PP_max(j,1)=max(p(j,1:12));
end


for i=1:length(p)-1
    for j=1:length(target)
    	d2(i,j)=(p(i+1,j)-p(i,j))^2;
    end
    d(i,1)=10000*sqrt(sum(d2(i)));
end


for i=1:length(p)-1
    dd2(i)=(PP_max(i+1)-PP_max(i))^2;
    dd(i,1)=sqrt(dd2(i));
end
