function [mu2] = MU2(x, data)
%% x1 x2 --- cols
xc = 1 - x(:,1) - x(:,2);

mu2 = data.g2 + log(x(:,2))+...
    +(1-x(:,2)).*(data.omega2*xc + data.omega12*x(:,1)) ...
    -data.omega1*xc.*x(:,1);
end