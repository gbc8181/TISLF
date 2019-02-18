%test
clc
clear
close all
% b is a threshold 

b=0.1;

%find the test and ad pigures
test=figurecell(4);
load('target.mat');
l_test=length(test);

%ad gray style
for n=1:length(target)
    i1=imread(char(target(n)));
    i2(n)={rgb2gray(i1)};
end

%recognition
%cell2mat(i2(1))
for i=1:l_test
    for j=1:length(target)
    %clearvars -EXCEPT num p judge test target b
    image1=imread(char(string(test(i))));
    %image2=imread(char(target(j)));
    image11=selectfigure(image1); %select and make it grey
    %image22=rgb2gray(image2);
        [num(i,j) p(i,j) grade(i,j)]=judge(image11,cell2mat(i2(j)),b);
    end
    %probability=p(i,:);
    %max_p(i)=max(p(i,:));
    
end

ad=cell(l_test,1);
p_rel=relventpro(p);

%decision

for t=1:l_test
    [max_p(t) ad_n(t)]=max(p_rel(t,:));
    ad(t)=(target(ad_n(t)));
end


