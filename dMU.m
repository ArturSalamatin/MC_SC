function [dmu] = dMU(x1, x2, data)
% 
% dmu1 = zeros(1,2,length(x1));
% dmu2 = zeros(1,2,length(x1));

dmu = zeros(2,2,length(x1));
xc = 1 - x1 - x2;

% dmu1/dx1
dmu(1,1,:) = 1./x1 - ...
    (data.omega1*xc+(data.omega12-data.omega2)*x2)-data.omega1*(1-x1);
% dmu1/dx2
dmu(1,2,:) = (1-x1)*(data.omega12-data.omega1) + ...
    data.omega2*(x2-xc);
% dmu2/dx1
dmu(2,1,:) = (1-x2)*(data.omega12-data.omega2) + ...
    data.omega1*(x1-xc);
%dmu2/dx2
dmu(2,2,:) = 1./x2 - ...
    (data.omega2*xc+(data.omega12-data.omega1)*x1)-data.omega2*(1-x2);
end


