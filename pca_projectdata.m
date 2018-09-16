function [Z] = pca_projectdata(X)

[m, n] = size(X);

% You need to return the following variables correctly.
U = zeros(n);
S = zeros(n);




sigma = (1/m) * X' * X ;
[U, S, V] = svd(sigma);


% For visualization application K = 2
K = 2; 

U_reduce = U(:,1:K);
Z = X * U_reduce;


end
