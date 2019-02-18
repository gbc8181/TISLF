% I will try to change it with any types later. 
%open the two plots
function [num p judge] = match(image1, image2)

image1=rgb2gray(image1);
image2=rgb2gray(image2);


[im1, des1, loc1] = sift(image1);
[im2, des2, loc2] = sift(image2);

distRatio = 0.55;   

% Select its match to second image for each descriptor in the first image.
% Matrix transpose

des2t = des2';

for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (vals(1) < distRatio * vals(2))
      match(i) = indx(1);
   else
      match(i) = 0;
   end
end

% show the two images side by side.

im3 = appendimages(im1,im2);

% Show a figure with lines joining the accepted matches.

figure('Position', [100 100 size(im3,2) size(im3,1)]);
colormap('gray');
imagesc(im3);
hold on;
cols1 = size(im1,2);

for i = 1: size(des1,1)
  if (match(i) > 0)
    line([loc1(i,2) loc2(match(i),2)+cols1], ...
         [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
  end
end

hold off;
%tabulate(match)
%Judge 
num = sum(match > 0);

[ttt total]=size(match);

    

fprintf('Found %d matches.\n', num);

