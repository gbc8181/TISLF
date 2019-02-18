function p_relvent=relventpro(p)

[p_y p_x]=size(p);
for i=1:p_y
	p_sum=sum(p(i,:));
	for j=1:p_x
		p_relvent(i,j)=p(i,j)/p_sum;
	end
	%max_p_relvent(i)=max(p_relvent(i,:));	
end
