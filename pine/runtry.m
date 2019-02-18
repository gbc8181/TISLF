%test
clc
clear
close all
% b is a threshold 
b=0.1;

AAA=rgb2gray(imread('EDGE.bmp'));
GRA=selectfigure(imread('3.bmp'));

%imshow(GRA)
match(GRA,AAA,b);