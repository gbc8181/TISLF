%test
clc
clear
close all
% b is a threshold 
b=0.1;


test={'1.bmp','2.bmp','3.bmp','4.bmp','5.bmp'};


target={'adidas.bmp','coca_1.bmp','flyemirates.bmp','McDonald.bmp','McDonald_1.bmp','sony.bmp','VISA.bmp','castrol.bmp','EDGE.bmp','hyundai.bmp','powerade.bmp','KIA.bmp','solar.bmp'};



for i=1:length(test)
    for j=1:length(target)
    %clearvars -EXCEPT num p judge test target b
    image1=imread(char(test(i)));
    image2=imread(char(target(j)));
    image11=selectfigure(image1); %select and make it grey
    image22=rgb2gray(image2);
        [num(i,j) p(i,j) grade(i,j)]=judge(image11,image22,b);
    end
    %probability=p(i,:);
    %max_p(i)=max(p(i,:));
    
end



for j=1:length(p)
    sum_p(j)=sum(p(:,j));
end

[max_sum_p max_p_position]=max(sum_p)
final_ad=target(max_p_position)
