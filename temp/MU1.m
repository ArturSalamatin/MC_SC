function [mu1] = MU1(x, data)
%% x1 x2 --- cols
xc = 1 - x(:,1) - x(:,2);

mu1 = data.g1 + log(x(:,1))+...
    +(1-x(:,1)).*(data.omega1*xc + data.omega12*x(:,2)) ...
    -data.omega2*xc.*x(:,2);
end