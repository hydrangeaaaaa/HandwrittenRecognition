function checkAccuracy(input)

% Get the according theta parameters 
load('thetaTem7.mat');

if strcmp(input, 'train')
	load('trainingData.mat');  	% Get the training data
elseif strcmp(input, 'test')
	load('testingData.mat');    % Get the testing data
else
	fprintf('\nThe parameter is not matched, please just input train or test\n');
	return;
end 

% Check the training set accuracy
pred = predict(Theta1, Theta2, X);

fprintf('\nThe Accuracy: %f\n', mean(double(pred == y)) * 100);

end