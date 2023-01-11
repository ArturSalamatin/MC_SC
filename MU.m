function [mu1,mu2,mu0] = MU(x1, x2, data)
mu1 = MU1(x1, x2, data);
mu2 = MU2(x1, x2, data);
mu0 = MU0(x1, x2, data);
end