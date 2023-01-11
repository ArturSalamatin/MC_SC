function [x1,x2,x3] = phase3equilib(data, xSat1, xSat2)


options = optimoptions('fmincon', 'OptimalityTolerance', 1E-20, ...
    'StepTolerance', 1E-20, 'FunctionTolerance', 1E-20, ...
    'ConstraintTolerance', 1E-12);


[x, f] = fmincon(@(x) J(x, data), [xSat1 xSat2], ...
    [1,1], [1], [], [], [], [], [], options);

f

x1 = x(1);
x2 = x(2);
x3 = 1 - x1 - x2;
end



function res = J(x, data)

x1 = x(1);
x2 = x(2);

[mu1, mu2] = MU(x1, x2, data);

res = (abs(mu1) + abs(mu2));

end