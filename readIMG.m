% This function just read img from current directoty 
% and transfer the image into gray scale and 28 * 28 pixels
function readIMG()

y = imread('number_4.jpg');
RGB = im2double(y);
%imshow(RGB);

%--------------------------
%[x, map] = rgb2ind(RGB);
%y = ind2gray (x, map);
%--------------------------

y = rgb2gray(RGB);
%figure
%imshow(y);

y = imresize(y, [28 28]);
%figure
%imshow(y);
imwrite(y,'out.jpg'); % Output the image
y = y(:);
y = y';

save('tem.mat', 'y');

end