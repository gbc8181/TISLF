function [result search_time]=readgroup(group,ad_var,ad_smaple_var,complex_threshold,p,ad_stay_time)
	sample=ad_smaple_var;
	result=zeros(size(ad_var));

	for n=1:length(sample)
		sample_var(n)=var(cell2mat(sample(n)));
    end

    
   % i=2;
    
	for i=1:size(group,2)
		clear data temp ad search_result;
		temp=group(:,i);

		for j=1:size(group,1)
			if (temp(j)>0)
				data(j)=temp(j);
			end
		end

		ad=ad_var(data,:);
		probability=p(data,:);

		%search_result_one=search_one(data,ad,sample_var,search_threshold);
        search_result_one=search_one(data,ad,complex_threshold);
		search_result_two=search_two(data,probability);

		for t=1:length(data)
			for j=1:length(sample)
				if((search_result_one(t,j)>0)&&(search_result_two(t,j)>0))
					search_result(t,j)=1;
				else
					search_result(t,j)=0;
				end
			end
		end

		result(data,:)=search_result;

		for m=1:length(sample)
			ad_cum(m)=sum(search_result(:,m));
		end
		time=zeros(1,length(sample));
		%[ad_re index]=sort(ad_cum);
		
		for m=1:length(sample)
			if (ad_cum(m)>=ad_stay_time)
				time(m)=ad_cum(m);
			else
				time(m)=0;
			end
		end

		search_time(i,:)=time;


	end

end