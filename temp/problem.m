function res = problem(x, data)
%% x = (x1, x2) --- initial guess for molar fractions, 2 cols
%% phi --- corresponding guess for chemical potential

phi = zeros(size(x));

[phi(:,1), phi(:,2), ~] = MU(x(:,1), x(:,2), data);




end