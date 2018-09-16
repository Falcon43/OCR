## Copyright (C) 2018 Aishwarya
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} hyperparameter_space (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Aishwarya <aishwaya@Aishwaryas-MacBook-Air.local>
## Created: 2018-09-08

function [retval] = hyperparameter_space ()

%  File structure :  g_m_L_hidden_lambda_MaxIter	

load("ex4data1.mat")

# random permutation of data
xperm = randperm(size(X,1));
X = X(xperm,:);
y = y(xperm,:);

# Training and validation    <Dataset Change>
X_cv = X(1:1250,:);
y_cv = y(1:1250,:);
X = X(1251:5000,:);
y = y(1251:5000,:);

vpred = [];
#vJtrain = [];
vJcv = [];


ihiddden = [10:10:56];
ilambda = [0:0.5:3];

idim = length(ihiddden);
jdim = length(ilambda);

for i = [10:10:56]
  for j = [0:0.5:3]
  
  

#initialize
input_layer_size  = size(X,2);  
hidden_layer_size = i;   
num_labels = 10;          

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

options = optimset('MaxIter', 50);
lambda = j;



% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, num_labels, X, y, lambda);

# Training
[nn_params, ~ ] = fmincg(costFunction, initial_nn_params, options);



% Predict

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), num_labels, (hidden_layer_size + 1));
 
[pred  Jcv ]  = predict(Theta1, Theta2, X_cv , y_cv);
fprintf('\nTraining Set Accuracy (Hidden: %d  Lambda: %.1f ): %f\n', i,j, mean(double(pred == y_cv)) * 100);


vpred = [vpred , pred];
vJcv = [vJcv , Jcv];



  endfor
endfor



% Plot
[xx, yy] = meshgrid (ilambda, ihiddden);
vpred = reshape(vpred,idim,jdim);
vJcv = reshape(vJcv,idim,jdim);

vpred
vJcv



subplot (2, 1, 1);
colormap ("default");
#Z = peaks ();
surf (xx,yy,vJcv);
shading interp;
colorbar ();
xlabel ("Lambda");
ylabel ("Hidden");
zlabel ("Jcv");
title ({"Jcv - Lambda - Hidden"});



subplot (2, 1, 2);
colormap ("default");
#Z = peaks ();
surf (xx,yy,vpred);
shading interp;
colorbar ();
xlabel ("Lambda");
ylabel ("Hidden");
zlabel ("Prediction");
title ({"Prediction - Lambda - Hidden"});






retval = 1;

endfunction
