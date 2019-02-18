function x=addispro(target_what_point)


if ~isempty(target_what_point)
    x=target_what_point(:,1);
    x=sort(x);
else
    x=0;
end

%y=var(x);

end