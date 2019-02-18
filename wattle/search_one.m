function result=search_one(data,ad,complex_threshold)

	for i=1:length(data)
		%number=data(i);
		%ad_temp=ad(i,:);
		for j=1:size(ad,2)
			%ad_var(i,j)=var(cell2mat(ad(i,j)));
			%distance_ad_sample(i,j)=abs(ad_var(i,j)/sample_var(j));
			distance_ad_sample=length(cell2mat(ad(i,j)));
			if(distance_ad_sample)>=complex_threshold;
				result(i,j)=1;
			else
				result(i,j)=0;
			end

		end
	end

end

