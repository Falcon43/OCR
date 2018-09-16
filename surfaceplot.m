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
## @deftypefn {Function File} {@var{retval} =} surfaceplot (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Aishwarya <aishwaya@Aishwaryas-MacBook-Air.local>
## Created: 2018-09-13

function [retval] = surfaceplot ()

#figure (3);

A = [ 1,2,3,4,5,6,7,8;
      21,32,34,12,76,54,21,1;
      23,34,6,7,8,21,32,3;
      12,76,54,21,5,6,7,8;
      5,6,7,8,32,3,12,76;
      32,34,12,76,54,21,1,23;
      8,5,6,7,8,32,3,12;
      1,2,3,4,5,6,7,8];
B = [ 17,18,14,15,16,11,12,13];
C = [ 24,28,27,21,25,26,23,22];

X = A+B;

colormap ("default");
#Z = peaks ();
surf (B,C,A);
title ({"surf() plot of peaks() function"; "color determined by height Z"});




figure (1);

Z = [ 1,1,1,1;
      2,2,2,2;
      3,3,3,3;
      4,4,4,4];
X = [ 17,14,11,13];
Y = [ 24,28,21,26];


colormap ("default");
#Z = peaks ();
surf (X,Y,Z);
title ({"surf() plot II  of peaks() function"; "color determined by height Z"});




figure (2);

Z = [ 1,2,3,4;
      1,2,3,4;
      1,2,3,4;
      1,2,3,4];
X = [ 17,14,11,13];
Y = [ 24,28,21,26];


colormap ("default");
#Z = peaks ();
surf (X,Y,Z);
title ({"surf() plot II  of peaks() function"; "color determined by height Z"});





figure(3);

a = [1:5];
b = [11:15];
c = a'.*b;


colormap ("default");
#Z = peaks ();
surf (a,b,c);
shading interp;
colorbar ();
xlabel ("a");
ylabel ("b");
zlabel ("c");

title ({"surf() plot II  of peaks() function"; "color determined by height Z"});



#D= [2;3;4;5;6;7;73];
#C = [1,2,3,4;5,6,7,8];
#outputdir ="/Users/aishwaya/Desktop/CODE/MachineLearning/HandwritingRecognition/HyperparameterTuning";

#for m = 1:8
#  for n = 1:7
#  endfor
#endfor

%save  [outputdir '/g_' int2str(5) '_' int2str(6)  '.mat']  A;
% save [outputdir '/g_' int2str(m) '_' int2str(n)  '.mat'] A B C x ;

retval = 1;

endfunction
