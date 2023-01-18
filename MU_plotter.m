function [x1, x2] = MU_plotter(vicinity, data)

x1 = linspace(0,vicinity,801);
x2 = linspace(0,vicinity,101);
[x1, x2] = meshgrid(x1,x2);
x1(x1+x2>1) = NaN;
x2(isnan(x1)) = NaN;

[mu1, mu2] = MU([x1(:), x2(:)], data);
mu1 = reshape(mu1, size(x1));
mu2 = reshape(mu2, size(x2));

figure(4)
hold on
contour(x1,x2,mu1, [0 0])
contour(x1,x2,mu2, [0 0])
end


