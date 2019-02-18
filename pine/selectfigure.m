function [result]=selectfigure(RGB)

GRAY = rgb2gray(RGB);
threshold = graythresh(GRAY);

%binary the picture
BW = im2bw(GRAY, threshold);
BW = ~ BW;

%randon transform
[R,xp]=radon(BW,-90);
%thb=1;


%Find the try possible part
bin=round(2207/2); %half
ran_temp=R(bin-540:bin+539);

%findpeaks(ran_temp)

l=length(ran_temp);
g(1)=0;

%bin_temp=[];
bin_temp_1=ran_temp(1:round(l/2));
bin_temp_2=ran_temp(1:round(l/2));

if (sum(bin_temp_1)>=sum(bin_temp_2))
	bin_temp=bin_temp_1;
else
	bin_temp=bin_temp_2;
end

%bin_temp=ran_temp;

%computation the thershold 
thb=200;
t=0;
ini=20;

for j=ini+1:length(bin_temp)
	k_judge=mean(bin_temp(j-ini:j));
	if (k_judge>thb)
		t=t+1;
		x_select(t)=j;
		y_select(t)=bin_temp(j);
	else
		t=t;
    end
    
end

%Here we need to cut the audience and reduce the search part.
l_search=length(x_select);
x_bin_select=x_select(round(l_search/3):l_search);

result=GRAY(x_bin_select,:);
end