function G = G_solution(vicinity, data)
global gibbsId
%% x1 x2 --- rows

x1 = linspace(0,vicinity,51);
x2 = linspace(0,vicinity,51);
[x1, x2] = meshgrid(x1,x2);
x1(x1+x2>1) = NaN;
x2(isnan(x1)) = NaN;
x0 = 1 - x1 - x2;

[mu1, mu2, mu0] = MU([x1(:), x2(:)], data);
mu1 = reshape(mu1, size(x1));
mu2 = reshape(mu2, size(x2));
mu0 = reshape(mu0, size(x0));

G = x1.*mu1 + x2.*mu2 + x0.*mu0;

G(x1 + x2 == 0) = 0;
G(x1 + x2 == 1) = 0;

if(~isempty(gibbsId))
    figure(gibbsId)
    surf(x1, x2, G)
end
end