function [mu2] = MU2(x1, x2, data)
%% x1 x2 --- rows
xc = 1 - x1 - x2;

mu2 = data.g2 + log(x2)+...
    +(1-x2).*(data.omega2*xc + data.omega12*x1) ...
    -data.omega1*xc.*x1;
end