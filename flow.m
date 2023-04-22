function [t,y] = flow(s1, s2, c1, c2, data)
global phaseEqId extractionId componentsSpecs phaseEqSpecs

segment = 1;
nodes_count = 401;

params.Mesh = set_mesh(s1, s2, segment, nodes_count);
%params.x = initial_guess_x(c1, c2, params.Mesh, data);
%params.phi = initial_guess_phi(params.x, data);
params.data = data;

options = odeset(...
    'Events', @(t,y) flow_event_1(t,y,params), ...
    'RelTol',1e-10,'AbsTol',1e-10 ...
    ... , 'NonNegative',[1,2], ...
    ... 'MaxStep', 1 ...
    );

[t,y,te,ye,ie] = ode45(...
    @(t,y) flow_ode(t,y,params), ...
    [0, 3.5], [c1, c2], options);

options = odeset(options, ...
    'Events', [], ...
    'MaxStep', 3E-1);
[t2,y2] = ode45(...
    @(t,y) flow_ode2(t,y,params), ...
    [t(end), 10], y(end,:), options);



figure(extractionId)
hold on
grid on
box on
plot(t, y(:,1), ...
    componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
plot(t, y(:,2), ...
    componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
plot(t, y(:,2)+y(:,1), ...
    'k', 'LineWidth', componentsSpecs.lw)


plot(t2, y2(:,1), ...
    componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
plot(t2, y2(:,2), ...
    componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
plot(t2, y2(1,2)*ones(size(t2)), ...
    [componentsSpecs.color2, '--'], 'LineWidth', componentsSpecs.lw)

plot(t2, y2(:,2)+y2(:,1), ...
    'k', 'LineWidth', componentsSpecs.lw)
plot(t2, y2(1,2)+y2(:,1), ...
    'k--', 'LineWidth', componentsSpecs.lw)


plot(t(end), y(end,1), 'k^', 'MarkerFaceColor', 'green', 'LineWidth', 1, ...
        'MarkerSize', phaseEqSpecs.markerSize)
plot(t(end), y(end,2), 'k^', 'MarkerFaceColor', 'green', 'LineWidth', 1, ...
        'MarkerSize', phaseEqSpecs.markerSize)
plot(t(end), y(end,1)+y(end,2), 'k^', 'MarkerFaceColor', 'green', 'LineWidth', 1, ...
        'MarkerSize', phaseEqSpecs.markerSize)
t(end)

figure(phaseEqId)
hold on
grid on
box on
plot(y(:,1), y(:,2), 'Linewidth', 2, 'Color', 'magenta')
plot(y2(:,1), y2(:,2), 'Linewidth', 2, 'Color', 'magenta')
plot(y(end,1), y(end,2), 'k^', 'MarkerFaceColor', 'green', 'LineWidth', 1, ...
        'MarkerSize', phaseEqSpecs.markerSize)

end

function dy = flow_ode(t,y, params)
c1 = y(1);
c2 = y(2);
%% get concentration distribution within a particle
[x,phi] = solute_distribution2([], [],...
    params.Mesh, params.data, c1, c2);

dy = (x(1+1,:)+x(1,:))/2.*...
    (phi(1+1,:)-phi(1,:))./...
    (params.Mesh.mesh(1+1)-params.Mesh.mesh(1))' ...
    ./[1/0.2,1/0.8] ...
    ;
dy = dy';
end

function [value, isterminal, direction] = ...
    flow_event_1(t,y,params)

[mu1, mu2] = MU(y', params.data);
% dDSQdt is the derivative of the equation for current distance. Local
% minimum/maximum occurs when this value is zero.
value = [mu1; mu2];
isterminal = [1;  1];        % stop when either mu_i=0
direction  = [0; 0];         %
end

function dy = flow_ode2(t,y, params)
c1 = y(1);
c2 = y(2);
%% get concentration distribution within a particle
[x,phi] = solute_distribution2([], [],...
    params.Mesh, params.data, c1, c2);

dy =(x(1+1,:)+x(1,:))/2.*...
    (phi(1+1,:)-phi(1,:))./...
    (params.Mesh.mesh(1+1)-params.Mesh.mesh(1))' ...
    ./[1/0.2,1/0.8] ...
    ;
dy = dy';
dMu2 = dMU2(x(1,:), params.data);
dy(2) = -dy(1)*dMu2(1)/dMu2(2);
end
