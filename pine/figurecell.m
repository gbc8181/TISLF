function test=figurecell(number_figure)

figure_style='.bmp';
for m=1:number_figure
    test(m,1)={strcat(int2str(m),figure_style)};
end