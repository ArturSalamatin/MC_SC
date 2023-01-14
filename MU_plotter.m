function [x1, x2] = MU_plotter(vicinity, data)

x1 = linspace(0,vicinity,801);
x2 = linspace(0,vicinity,101);
[x1, x2] = meshgrid(x1,x2);
x1(x1+x2>1) = NaN;
x2(isnan(x1)) = NaN;

mu1 = zeros(size(x1));
mu2 = mu1;
for p = 1:size(x1, 2)
[mu1(:,p), mu2(:,p)] = MU([x1(:,p), x2(:,p)], data);
end
figure(4)
hold on
contour(x1,x2,mu1, [0 0])
contour(x1,x2,mu2, [0 0])
end


