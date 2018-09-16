function [J grad J_trainVect nn_paramsVect] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda )
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
J_trainVect = [];
nn_paramsVect = [];
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%





% recode y to Y
Y = zeros(m, num_labels);
for r = 1:m 
    Y(r , y(r))  = 1;
end

% Explode y into 10 values with Y[i] := i == y.
%Y = zeros(num_labels, m);
%Y(sub2ind(size(Y), y', 1:m)) = 1;



% Feedforward propagation algorithm : calculate hypothesis
a1 = [ones(m,1) , X];   % m x 401
z2 = a1 * Theta1' ;   % m x 25   
a2 = [ones(size(z2, 1),1) , sigmoid(z2)];   % m x 26
z3 = a2 * Theta2' ;
h0x = (sigmoid(z3));


% calculate  penalty
p = sum(sum( Theta1(:,2:end).^2 ))  + sum(sum(Theta2(:,2:end).^2  ));


% calculate cost  with regularization
J  = (-1/m * sum(sum( (Y .* log(h0x)) +  ((1-Y).*log(1-h0x)) ))) + lambda * p / (2*m) ;
J_trainVect = [ J_trainVect , J ];


% Back propagation algorithm with regularization

for i = 1:m
    % calculate delta
    delta_3 = h0x(i,:) - Y(i,:);   % 1 x 10
    delta_2 = ( delta_3 * Theta2 ) .* sigmoidGradient([1,z2(i,:)]) ;   % 1 x 26

    % accumulate
    Theta2_grad = Theta2_grad + delta_3' * a2(i,:);   % 10 x 26
    Theta1_grad = Theta1_grad + delta_2(2:end)' * a1(i,:);   % 26 x 401
    % you do calculate the delta for bias unit but when you accumulate, you dont consider the bias unit
end

Theta2_grad = Theta2_grad ./ m + [zeros(size(Theta2,1),1) , (lambda/m) * Theta2(:,2:end)];
Theta1_grad = Theta1_grad ./ m + [zeros(size(Theta1,1),1) , (lambda/m) * Theta1(:,2:end)];







% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


nn_paramsVect = [ nn_paramsVect , grad ] ;




end
