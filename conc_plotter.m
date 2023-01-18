function conc_plotter(s1, s2, c1, c2, segment, nodes_count, data)
global phaseEqId concDistribId muDistribId 
global concDistrib componentsSpecs
%% overall grid
mesh = linspace(0, segment, nodes_count); % coordinates
z1_idx = 1:round(nodes_count*s1); % indexies of transport zone 1
s1_idx = z1_idx(end); % index of boundary 1 position
% s1 = mesh(s1_idx); % reassign boundary 1 position
z2_idx = 1:round(nodes_count*s2); % indexies of transport zone 2
s2_idx = z2_idx(end); % index of boundary 2 position
% s2 = mesh(s2_idx); % reassign boundary 2 position
%% x-guess
x = zeros(nodes_count, 2);
%% a simple initial x-guess
x(1:s1_idx, 1) = linspace(c1, data.sat.x1, s1_idx);
x(1:s2_idx, 2) = linspace(c2, data.sat.x2, s2_idx);
n = max(s1_idx, s2_idx);
if(s1_idx < s2_idx)
    x(s1_idx:s2_idx, 1) = data.sat.x1;
else
    x(s2_idx:s1_idx, 2) = data.sat.x2;
end
% concentration in the core
x(n:end, 1) = data.sat.x1;
x(n:end, 2) = data.sat.x2;
%% a more accurate initial x-guess
% if(s1 > s2)
%     %% internal core
%     % here is a three-phase equilibrium observed
%     x(s1_idx:end, 1) = data.sat.x1;
%     x(s1_idx:end, 2) = data.sat.x2;
%     %% external core
%     x(1:s1_idx, 1) = linspace(c1, data.sat.x1, s1_idx); % and transport zone
%     x(s2_idx:s1_idx, 2) = linspace(data.xSat2, data.sat.x2, s1_idx - s2_idx+1);
%     % external transport zone
%     x(1:s2_idx, 2) = linspace(c2, data.xSat2, s2_idx);
% else % s2 > s1
%     %% internal core
%     % here is a three-phase equilibrium observed
%     x(s2_idx:end, 1) = data.sat.x1;
%     x(s2_idx:end, 2) = data.sat.x2;
%     %% external core
%     x(1:s2_idx, 2) = linspace(c2, data.sat.x2, s1_idx); % and transport zone
%     x(s1_idx:s2_idx, 1) = linspace(data.xSat1, data.sat.x1, s2_idx - s1_idx+1);
%     % external transport zone
%     x(1:s1_idx, 1) = linspace(c1, data.xSat1, s1_idx);
% end
%% mu-guess
phi = zeros(size(x));
[phi(:,1), phi(:,2)] = MU(x, data);
%% get concentration distribution within a particle
[x,phi] = solute_distribution2(x, phi,...
    s1_idx, s2_idx, data, c1, c2);
%% plots
% concentration distribution in the particle
% as function of position
if(~isempty(muDistribId))
    figure(muDistribId)
    plot(mesh, phi(:,1), ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
    plot(mesh, phi(:,2), ...
        componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
end
% concentration distribution in the particle
% as function of position
if(~isempty(concDistribId))
    figure(concDistribId)
    plot(mesh, x(:,1), ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
    plot(mesh, x(:,2), ...
        componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
end
% concentration distribution in the particle
% in the phase diagram
if(~isempty(phaseEqId))
    figure(phaseEqId)
    plot(x(:,1), x(:,2), ...
        concDistrib.color, 'LineWidth', concDistrib.lw)
end
end