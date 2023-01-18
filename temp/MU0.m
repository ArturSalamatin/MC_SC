function [mu0] = MU0(x, data)
%% x1 x2 --- cols
xc = 1 - x(:,1) - x(:,2);

mu0 = log(xc)+...
    +(1-xc).*(data.omega1*x(:,1) + data.omega2*x(:,2)) ...
    -data.omega12*x(:,1).*x(:,2);
end