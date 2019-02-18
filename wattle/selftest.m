clc
clear
close all

%parpool

b=0.1;

%find the test and ad pigures
test=figurecell(1);
load('target.mat');
l_test=length(test);

num=zeros(l_test,length(target));
p=zeros(l_test,length(target));

%ad gray style

l_target=length(target);

for n=1:l_target
    i1=rgb2gray(imread(char(target(n))));
    %i2(n)={i1};
    [im2, des2, loc2]=sift(i1);
    im2cell(n)={im2};
    des2cell(n)={des2};
    loc2cell(n)={loc2};
end


%aa=cell2mat(l3(3));
i=1;
    
for j=1:l_target
    %image22=cell2mat(i2(j));
   % for i=1:l_target
    %clearvars -EXCEPT num p judge test target b
    %image2=imread(char(target(j)));
    %image22=rgb2gray(image2);
    [num(i,j),p(i,j),target_what_point total(i,j)]=judge(cell2mat(im2cell(j)),cell2mat(des2cell(j)),cell2mat(loc2cell(j)), ...
    cell2mat(im2cell(j)),cell2mat(des2cell(j)),cell2mat(loc2cell(j)),b);
    %parfeval(gcp(),judge(cell2mat(l3(i)),cell2mat(i2(j)),b),1,2)
    ad_smaple_var(i,j)={addispro(target_what_point)};
   % end
end

save sample.mat ad_smaple_var