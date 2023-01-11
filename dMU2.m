function dmu2dx2 = dMU2(x1, x2, data)
% 
% dmu1 = zeros(1,2,length(x1));
% dmu2 = zeros(1,2,length(x1));

dmu2dx2 = 1./x2 - ...
    (data.omega2*xc+(data.omega12-data.omega1)*x1)-data.omega2*(1-x2);
end