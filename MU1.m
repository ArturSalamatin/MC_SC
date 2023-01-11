function [mu1] = MU1(x1, x2, data)
%% x1 x2 --- rows
xc = 1 - x1 - x2;

mu1 = data.g1 + log(x1)+...
    +(1-x1).*(data.omega1*xc + data.omega12*x2) ...
    -data.omega2*xc.*x2;
end