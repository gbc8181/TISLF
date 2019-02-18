%a1=imread('25.bmp');
%a2=imread('26.bmp');

test=figurecell(100);
for i=1:length(test)
        a=imread(char(string(test(i))));
        %a2=imread(char(string(test(i+1))));
        a=rgb2gray(a);
        %a2=rgb2gray(a2);
        M(i)={a};
end

for j=1:length(test)-1
    Num(j)=judge(cell2mat(M(j)),cell2mat(M(j+1)),0.5);
end

plot(Num)