% Neural Network 

%% Initialization
clear ; close all; clc

%% Setup the parameters 
input_layer_size  = 784;  % 28x28 Input Images of Digits
hidden_layer_size = 25;   % 25 hidden units
num_labels = 10;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')
load('trainingData.mat');

% Randomly select 100 data points to display
sel = randperm(size(X, 1));
sel = sel(1:100);

displayData(X(sel, :));

fprintf('\nLoading Saved Neural Network Parameters ...\n')

% Load the weights into variables Theta1 and Theta2
load('thetaTem6.mat'); 

% Unroll parameters 
nn_params = [Theta1(:) ; Theta2(:)]; 

% ----------------------------------
% Or you can train your own theta from random initialization
% Initialise the initial theta value

%initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
%initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
%initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%------------------------------------

fprintf('\nChecking Backpropagation... \n');

% Check gradients by running checkNNGradients
checkNNGradients;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

fprintf('\nChecking Backpropagation (w/ Regularization) ... \n')

% Check gradients by running checkNNGradients
lambda = 3;
checkNNGradients(lambda);

% Also output the costFunction debugging values
debug_J  = nnCostFunction(nn_params, input_layer_size, ...
                          hidden_layer_size, num_labels, X, y, lambda);

fprintf(['\n\nCost at (fixed) debugging parameters (w/ lambda = %f): %f ' ...
        '\n(for lambda = 3, this value should be about 0.300929)\n\n'], lambda, debug_J);

fprintf('Program paused. Press enter to continue.\n');
pause;

fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 50);

%  You should also try different values of lambda
lambda = 1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('Program paused. Press enter to continue.\n');
pause;

% Sava the training result
save('theta.mat', 'Theta1', 'Theta2');





