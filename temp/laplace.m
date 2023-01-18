function [phi] = laplace(x, mu_BC)

n = length(x);

D = (x(1:(n-1))+x(2:n))/2;

I = [1,2:(n-1), 2:(n-1), 2:(n-1),n];
J = [1,1:(n-2), 2:(n-1), 3:n, n];
val = [1; D(1:(n-2)); -(D(1:(n-2))+D(2:(n-1))); D(2:(n-1)); 1];


A = sparse(I, J, val, n, n);
b = zeros(n,1);
b([1,n]) = mu_BC;

phi = A\b;

end