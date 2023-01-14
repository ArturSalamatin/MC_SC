function [] = conc_plotter(s1, s2, c1, c2, segment, nodes_count, data)
%% overall grid
z = linspace(0, segment, nodes_count); % coordinates
z1_idx = 1:round(nodes_count*s1); % indexies of transport zone 1
s1_idx = z1_idx(end); % index of boundary 1 position
s1 = z(s1_idx); % reassign boundary 1 position
z2_idx = 1:round(nodes_count*s2); % indexies of transport zone 2
s2_idx = z2_idx(end); % index of boundary 2 position
s2 = z(s2_idx); % reassign boundary 2 position
%% x-guess
x = zeros(nodes_count, 2);
if(s1 > s2)
    %% internal core
    % here is a three-phase equilibrium observed
    x(s1_idx:end, 1) = data.sat.x1;
    x(s1_idx:end, 2) = data.sat.x2;
    %% external core
    x(1:s1_idx, 1) = linspace(c1, data.sat.x1, s1_idx); % and transport zone
    x(s2_idx:s1_idx, 2) = linspace(data.xSat2, data.sat.x2, s1_idx - s2_idx+1);
    % external transport zone
    x(1:s2_idx, 2) = linspace(c2, data.xSat2, s2_idx);
else % s2 > s1
    %% internal core
    % here is a three-phase equilibrium observed
    x(s2_idx:end, 1) = data.sat.x1;
    x(s2_idx:end, 2) = data.sat.x2;
    %% external core
    x(1:s2_idx, 2) = linspace(c2, data.sat.x2, s1_idx); % and transport zone
    x(s1_idx:s2_idx, 1) = linspace(data.xSat1, data.sat.x1, s2_idx - s1_idx+1);
    % external transport zone
    x(1:s1_idx, 1) = linspace(c1, data.xSat1, s1_idx);
end
%% mu-guess
phi = zeros(size(x));
[phi(:,1), phi(:,2)] = MU(x, data);
%% get concentration distribution within a particle
[x,phi] = solute_distribution(x, phi,...
    s1_idx, s2_idx, data);


figure(1248)
plot(x(:,1))
plot(x(:,2))

end