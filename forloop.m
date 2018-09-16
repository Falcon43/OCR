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
## @deftypefn {Function File} {@var{retval} =} forloop (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Aishwarya <aishwaya@Aishwaryas-MacBook-Air.local>
## Created: 2018-09-13

function [retval] = forloop ()

x = [50,100, 150,200,250,300,350,400,450,500,550,600];
y = [0, 0.2, 0.4, 0.6, 0.8, 1, 1.2, 1.4, 1.6, 1.8, 2, 2.2, 2.4, 2.6,2.8, 3, 3.2, 3,4 , 3.6, 3.8, 4 ,5,6,7,8,9,10,15,20,25,30];

idim = length(x);
jdim = length(y);
  
  
vm = [];
va = [];

for i = [50,100, 150,200,250,300,350,400,450,500,550,600]
  for j = [0, 0.2, 0.4, 0.6, 0.8, 1, 1.2, 1.4, 1.6, 1.8, 2, 2.2, 2.4, 2.6,2.8, 3, 3.2, 3,4 , 3.6, 3.8, 4 ,5,6,7,8,9,10,15,20,25,30]
  
     m = i*j;
     vm = [vm  , m];
     a = i+j;
     va = [va  , a];

     fprintf('\n (i: %f  j: %.1f ): %f  and  %f \n ', i,j, m, a);

  endfor
endfor

  





% Plot
[xx, yy] = meshgrid (y, x);
vm = reshape(vm,idim,jdim);
va = reshape(va,idim,jdim);

vm
va

subplot (2, 1, 1);
colormap ("default");
#Z = peaks ();
surf (xx,yy,vm);
shading interp;
colorbar ();
xlabel ("Lambda");
ylabel ("Hidden");
zlabel ("Jcv");
title ({"Jcv - Lambda - Hidden"});



subplot (2, 1, 2);
colormap ("default");
#Z = peaks ();
surf (xx,yy,va);
shading interp;
colorbar ();
xlabel ("Lambda");
ylabel ("Hidden");
zlabel ("Prediction");
title ({"Prediction - Lambda - Hidden"});

  
  
  
  
  
retval = 1;

endfunction
