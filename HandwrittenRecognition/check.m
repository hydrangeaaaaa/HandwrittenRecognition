% This function just process the input image
% to get black background and white digits

function p = check()
	load('theta.mat');

	load('tem.mat');

	zz = reshape(y,28,28);
	yy = 1.-zz;
	yy = abs(yy);
	for i = 1:size(yy,1)
		for j = 1:size(yy,2)
			if yy(i,j)<0.4
				yy(i,j) = 0;
		    elseif yy(i,j)>0.7
		    	yy(i,j) = 1;
		    end
		end
	end
	imshow(yy);
	imwrite(yy, 'out.jpg'); % Output the image
	xx = yy(:);
	xx = xx';
	p = predict(Theta1, Theta2, xx);
end