function G = G_solution(x1, x2, data)
%% x1 x2 --- rows
x0 = 1 - x1 - x2;

mu1 = MU1(x1, x2, data);
mu2 = MU2(x1, x2, data);
mu0 = MU0(x1, x2, data);

G = x1.*mu1 + x2.*mu2 + x0.*mu0;


G(x1 + x2 ==0) = 0;
G(x1 + x2==1) = 0;

% G(x1+x2 > 0.5) = NaN;


figure(12)
surf(x1, x2, G)

end