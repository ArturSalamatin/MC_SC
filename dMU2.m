function dmu2 = dMU2(x, data)
% Gradient of the mu = (mu1; mu2) vector,
% i.e., matrix of first derivatives

% dmu1 = zeros(1,2,length(x1));
% dmu2 = zeros(1,2,length(x1));

dmu2 = zeros(size(x,1),2);
xc = 1 - x(:,1) - x(:,2);

% dmu2/dx1
dmu2(:,1) = (1-x(:,2))*(data.omega12-data.omega2) + ...
    data.omega1*(x(:,1)-xc);
%dmu2/dx2
dmu2(:,2) = 1./x(:,2) - ...
    (data.omega2*xc+(data.omega12-data.omega1)*x(:,1))-data.omega2*(1-x(:,2));
end

