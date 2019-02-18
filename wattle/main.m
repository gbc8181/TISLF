%% High resolution pipeline
% path
path_target='../target_images/';
path_source='../source_images/';

dir_target=dir(strcat(path_target,'*.jpg'));
dir_source=dir(strcat(path_source,'*.bmp'));

total_pictures=length(dir_source);

b=0.1;
target={dir_target.name};
test={dir_source.name};


l_test=length(test);

num=zeros(l_test,length(target));
p=zeros(l_test,length(target));
l_target=length(target);

for m=1:l_test
    file_test_name=strcat(path_source,char(test(m)));
    l1=imread(file_test_name);  
    s_a=size(l1);
    l11=imresize(l1, [s_a(1) s_a(2)]/2);
    l2=(rgb2gray(l11));
    [im1, des1, loc1] = sift(l2);
    im1cell(m)={im1};
    des1cell(m)={des1};
    loc1cell(m)={loc1};
end

for n=1:l_target
    file_target_name=strcat(path_target,char(target(n)));
    i1=rgb2gray(imread(file_target_name));
    [im2, des2, loc2]=sift(i1);
    im2cell(n)={im2};
    des2cell(n)={des2};
    loc2cell(n)={loc2};
end


for j=1:l_target
    %image22=cell2mat(i2(j));
    
    for i=1:l_test
    %clearvars -EXCEPT num p judge test target b
    %image2=imread(char(target(j)));
    %image22=rgb2gray(image2);
    try
         [num(i,j),p(i,j),target_what_point]=judge(cell2mat(im1cell(i)),cell2mat(des1cell(i)),cell2mat(loc1cell(i)), ...
    cell2mat(im2cell(j)),cell2mat(des2cell(j)),cell2mat(loc2cell(j)));
    catch
         num(i,j)=0;
         p(i,j)=0;
         target_what_point=[];
    end
         
    %parfeval(gcp(),judge(cell2mat(l3(i)),cell2mat(i2(j)),b),1,2)
    ad_var(i,j)={addispro(target_what_point)};
    end
end

%delete(MyPar)

ad=cell(l_test,1);
p_rel=relventpro(p);

for t=1:l_test
    [max_p(t) ad_n(t)]=max(p_rel(t,:));
    ad(t)=(target(ad_n(t)));
end

save data.mat p target ad_var


%delete(gcp('nocreate')) 

%% part2

clear

%b=0.1;

%find the test and target images
%parpool
path_target='../target_images/';
path_source='../source_images/';

dir_target=dir(strcat(path_target,'*.jpg'));
dir_source=dir(strcat(path_source,'*.bmp'));

total_pictures=length(dir_source);
target={dir_target.name};

b=0.1;

test=figurecell(total_pictures);
l_test=length(test);

num=zeros(l_test,length(target));
p=zeros(l_test,length(target));

%target gray style images

l_target=length(target);

for n=1:l_target
    file_target_name=strcat(path_target,char(target(n)));
    i1=rgb2gray(imread(file_target_name));
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
%% part3

% divide into different groups
% decision process
% This decision not includes Estimation Stage in paper. We are working on
% modifying the codes of it.

clc
clear

load('Num.mat');

threshold=10;
group=cutpart(threshold,Num);

%search_threshold=0.6; not used here
complex_threshold=20;
ad_stay_time=2;

load('data.mat');
load('sample.mat');

[result time]=readgroup(group,ad_var,ad_smaple_var,complex_threshold,p,ad_stay_time);

for i=1:length(target)
    ad_time_cum(i)=sum(result(:,i));
end

hold on
stem(ad_time_cum) 
xlabel('Target number');
ylabel('Time(s)')
set(gca,'FontSize',20)
hold off

[time_x time_y]=size(result);

con=0;

for ty=1:time_y
    for tx=1:time_x
        if(result(tx,ty)==1)
            con=con+1;
            check(con,ty)=tx;
        end
        
    end
    con=0;
end
