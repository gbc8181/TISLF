%% Low Resolution Pipeline
% Path

path_source='../source_images/';
dir_source=dir(strcat(path_source,'*.bmp'));
total_pictures=length(dir_source);

% threshold to segment video to different scenes
b=0.1;

%find the test and ad pigures
%test=figurecell(total_pictures);

test=figurecell(total_pictures);

for i=1:length(test)
        file_test_name=strcat(path_source,char(test(i)));
        a=imread(file_test_name);
        s_a=size(a);
        a=imresize(a, [s_a(1) s_a(2)]/4);
        %a2=imread(char(string(test(i+1))));
        a=rgb2gray(a);
        %a2=rgb2gray(a2);
        M(i)={a};
end


% parallelly segment videos

gcd=parpool(4);

parfor j=1:length(test)-1
    %file_test_name=strcat(path_source,char(test(j)));
    %file_test_name_next=strcat(path_source,char(test(j+1)));
    try
          Num(j)=judge(cell2mat(M(j)),cell2mat(M(j+1)),0.5);
    catch
         Num(j)=0;
    end
         
               
end

delete(gcd)
clear a i test j M
save Num.mat Num