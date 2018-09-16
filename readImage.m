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





function [X , y, X_cv, y_cv, X_test, y_test] = readImage (list,imagesource)
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
  img_test = imread ([imagesource "/" list.ALLnames(list.TSTind(ind_test(ii),end),:) ".png"]);   # read image file
  X_test = [X_test ; img_test(:)' ] ;    ## MANIPULATE IMAGE
  #disp(size(imagedata));
  
  y_test = [ y_test ; list.ALLlabels(list.TSTind(ind_test(ii),end)) ];
  
  
end



X = double(X);
X_test = double(X_test);
X_cv = double(X_cv);


endfunction
