function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

X = [ones(m, 1) X];

% vectorize the y
yv = zeros(m, num_labels);

for i = 1:m
	yv(i, y(i)) = 1;
end

a1 = X;
a2 = [ones(m, 1) sigmoid(a1*Theta1')];
a3 = sigmoid(a2*Theta2');

for i=1:m
    J += (-yv(i,:))*log(a3(i,:))' - (1 .- yv(i,:))*log(1 - a3(i,:))';
end
J = J/m;

Theta = [Theta1(:,2:end)(:); Theta2(:,2:end)(:)]; % means vector these matrix into only one column vector
J += (lambda/(2*m))*sum(Theta.**2);

theta_2_grad = 0;
theta_3_grad = 0;

for t=1:m
    a1 = X(t, :)';
    z2 = Theta1*a1;
    a2 = [1 ; sigmoid(z2)];
    z3 = Theta2*a2;
    a3 = sigmoid(z3);

    delta_3 = a3 - yv(t, :)';
    delta_2 = Theta2'*delta_3.*[1 ; sigmoidGradient(z2)];
    
    Theta2_grad += delta_3*a2';
    Theta1_grad += delta_2(2:end)*a1';
end

Theta2_grad = Theta2_grad./m;
Theta1_grad = Theta1_grad./m;

Theta2_grad(:, 2:end) += (lambda/m)*Theta2(:, 2:end);
Theta1_grad(:, 2:end) += (lambda/m)*Theta1(:, 2:end);


% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
