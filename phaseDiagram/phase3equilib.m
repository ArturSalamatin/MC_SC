function [data,x1,x2,x3] = phase3equilib(data)
% find solution concentration at three-phase equilibrium
% through the minimization of |mu1| + |mu2|


[curve1, curve2] = curve_tracer(data);
data.curve1.x1 = curve1(:,1);
data.curve1.x2 = curve1(:,2);
data.curve2.x1 = curve2(:,1);
data.curve2.x2 = curve2(:,2);


%% set the minimization algorithm options
% options = optimoptions('fmincon', 'OptimalityTolerance', 1E-20, ...
%     'StepTolerance', 1E-20, 'FunctionTolerance', 1E-20, ...
%     'ConstraintTolerance', 1E-15);
options = optimoptions('fminunc', 'OptimalityTolerance', 1E-20, ...
    'StepTolerance', 1E-20);
%% call the minimizer
[x, f] = fminunc(@(x) J(x, data), (curve1(end,:)+curve2(end,:))/2, ...
    options);
f
%% return data
x1 = x(1);
x2 = x(2);
x3 = 1 - x1 - x2;
data.sat = struct('x1', x1, 'x2', x2);
end
%% target function, to be minimized
function res = J(x, data)
mu = zeros(size(x));
[mu(:,1), mu(:,2)] = MU(x, data);
res = sum(abs(mu(:)));
end