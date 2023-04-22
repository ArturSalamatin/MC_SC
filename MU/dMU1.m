function dmu1 = dMU1(x, data)
% Gradient of the mu = (mu1; mu2) vector,
% i.e., matrix of first derivatives

% dmu1 = zeros(1,2,length(x1));
% dmu2 = zeros(1,2,length(x1));

dmu1 = zeros(size(x,1),2);
xc = 1 - x(:,1) - x(:,2);

% dmu1/dx1
dmu1(:,1) = 1./x(:,1) - ...
    (data.omega1*xc+(data.omega12-data.omega2)*x(:,2))-data.omega1*(1-x(:,1));
% dmu1/dx2
dmu1(:,2) = (1-x(:,1))*(data.omega12-data.omega1) + ...
    data.omega2*(x(:,2)-xc);
end