function [mu0] = MU0(x1, x2, data)
%% x1 x2 --- rows
xc = 1 - x1 - x2;

mu0 = log(xc)+...
    +(1-xc).*(data.omega1*x1 + data.omega2*x2) ...
    -data.omega12*x1.*x2;
end