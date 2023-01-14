function [mu1,mu2,mu0] = MU(x, data)
%% x1 x2 --- cols of x
mu1 = MU1(x, data);
mu2 = MU2(x, data);
if(nargout == 3)
    mu0 = MU0(x, data);
end
end