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
## @deftypefn {Function File} {@var{retval} =} readImage (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Aishwarya <aishwaya@Aishwaryas-MacBook-Air.local>
## Created: 2018-09-08





function [X , y, X_cv, y_cv, X_test, y_test] = OCR (list,imagesource)



X = [];
y = [];
X_cv = [];
y_cv = [];
X_test = [];
y_test = [];
#addpath(imagesource);
#dirimagesource = dir([imagesource '/**/*.png']);   # get struct of info on .jpg's in directory

# Random permutation of Training set
ind = randperm(length(list.TRNind(:,end)));
ind_test = randperm(length(list.TSTind(:,end)));
ind_cv = randperm(length(list.VALind(:,end)));
#list.TRNind(ind,end)

#for ii = 1:length (list.TRNind(:,end))   # loop over png files
for ii = 1:10   # loop over png files
  img = imread ([imagesource "/" list.ALLnames(list.TRNind(ind(ii),end),:) ".png"]);   # read image file
  X = [X ; img(:)' ] ;    ## MANIPULATE IMAGE
  #disp(size(imagedata));
  
  y = [ y ; list.ALLlabels(list.TRNind(ind(ii),end)) ];
end

  
for ii = 1:10   # loop over png files
  
  %Cross validation dataset
  img_cv = imread ([imagesource "/" list.ALLnames(list.VALind(ind_cv(ii),end),:) ".png"]);   # read image file
  X_cv = [X_cv ; img_cv(:)' ] ;    ## MANIPULATE IMAGE
  #disp(size(imagedata));
  
  y_cv = [ y_cv ; list.ALLlabels(list.VALind(ind_cv(ii),end)) ];
  
  
  % TEST dataset
  #img_test = imread ([imagesource "/" list.ALLnames(list.TSTind(ind_test(ii),end),:) ".png"]);   # read image file
  #X_test = [X_test ; img_test(:)' ] ;    ## MANIPULATE IMAGE
  #disp(size(imagedata));
  
  #y_test = [ y_test ; list.ALLlabels(list.TSTind(ind_test(ii),end)) ];
  
  
end



X = double(X);
#X_test = double(X_test);
X_cv = double(X_cv);




# Single Training





#initialize
input_layer_size  = size(X,2);  
hidden_layer_size = 300;   
num_labels = list.NUMclasses;          

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

options = optimset('MaxIter', 50);
lambda = 1;



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


#vpred = [vpred ,  mean(double(pred == y_cv)) * 100];
#vJcv = [vJcv , Jcv];



pred

Jcv





endfunction
