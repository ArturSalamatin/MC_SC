function [mu1,mu2,mu0] = MU(x, data)
%% x1 x2 --- cols of x
mu1 = MU1(x, data);
mu2 = MU2(x, data);
if(nargout == 3)
    mu0 = MU0(x, data);
end
end


function [mu0] = MU0(x, data)
%% x1 x2 --- cols
xc = 1 - x(:,1) - x(:,2);

mu0 = log(xc)+...
    +(1-xc).*(data.omega1*x(:,1) + data.omega2*x(:,2)) ...
    -data.omega12*x(:,1).*x(:,2);
end

function [mu1] = MU1(x, data)
%% x1 x2 --- cols
xc = 1 - x(:,1) - x(:,2);

mu1 = data.g1 + log(x(:,1))+...
    +(1-x(:,1)).*(data.omega1*xc + data.omega12*x(:,2)) ...
    -data.omega2*xc.*x(:,2);
end

function [mu2] = MU2(x, data)
%% x1 x2 --- cols
xc = 1 - x(:,1) - x(:,2);

mu2 = data.g2 + log(x(:,2))+...
    +(1-x(:,2)).*(data.omega2*xc + data.omega12*x(:,1)) ...
    -data.omega1*xc.*x(:,1);
end