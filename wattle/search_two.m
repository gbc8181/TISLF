% functionname: function description
function result = search_two(data,probability)
	for i=1:length(data)
		%p_mean=mean(probability(i,:));
        p_mean=0.5*max(probability(i,:));
		for j=1:size(probability,2)
			if (probability(i,j)>p_mean)
				result(i,j)=probability(i,j);
			else
				result(i,j)=0;
			end
		end
	end
end


