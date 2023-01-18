function [curve1, curve2] = curve_tracer(data)
%% trace curve mu2(x)==0
options2 = odeset(...
    'RelTol', 1E-6, 'AbsTol', 1E-6, ...
    'NonNegative', [1,2], ...
    'MaxStep', 1E-2, ...
    'Events', @(t,y) events_mu2eq0(t,y, data));
[~,curve2] = ode45(@(t,y) ode_mu2eq0(t,y,data), [0, 5], [0, data.xSat2], options2);
%% trace curve mu1(x)==0
options1 = odeset(...
    'RelTol', 1E-5, 'AbsTol', 1E-5, ...
    'NonNegative', [1,2], ...
    'MaxStep', 1E-2, ...
    'Events', @(t,y) events_mu1eq0(t,y, data));
[~,curve1] = ode45(@(t,y) ode_mu1eq0(t,y,data), [0, 5], [data.xSat1, 0], options1);
end



function dy = ode_mu2eq0(t,y, data)

dy = zeros(2,1);

dmu = dMU2(y', data); % transpose if y is a col-vector

ratio = dmu(:,1)./dmu(:,2);

dy(1) = 1./sqrt(1+ratio.^2);
dy(2) = -ratio*dy(1);

end

function [value,isterminal,direction] = events_mu2eq0(t,y, data)
% dDSQdt is the derivative of the equation for current distance. Local
% minimum/maximum occurs when this value is zero.
[mu,~] = MU(y', data);
value = [y(1); y(1)+y(2)-1; mu];  
isterminal = [1;  1; 1];         % stop at local minimum
direction  = [-1; 1; 0];         % [local minimum, local maximum]
end


function dy = ode_mu1eq0(t,y, data)

dy = zeros(2,1);

dmu = dMU1(y', data); % transpose if y is a col-vector

ratio = dmu(:,2)./dmu(:,1);

dy(2) = 1./sqrt(1+ratio.^2);
dy(1) = -ratio*dy(2);

end

function [value,isterminal,direction] = events_mu1eq0(t,y, data)
% dDSQdt is the derivative of the equation for current distance. Local
% minimum/maximum occurs when this value is zero.
[~,mu] = MU(y', data);
value = [y(2); y(1)+y(2)-1; mu];  
isterminal = [1;  1; 1];         % stop at local minimum
direction  = [-1; 1; 0];         % [local minimum, local maximum]
end

