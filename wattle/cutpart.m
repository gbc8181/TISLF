function part=cutpart(threshold,Num)
%load('Num.mat');

%threshold=10; %match thershold point
part=[];  %part
a=1;
b=1;

for t=1:length(Num)
	if(Num(t)>=threshold)
		part(a,b)=t;
        a=a+1;
    else
        part(a,b)=t;
        b=b+1;
		a=1;
        %a=a+1;
    end
end

end


