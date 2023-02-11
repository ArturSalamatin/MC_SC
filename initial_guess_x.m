function x = initial_guess_x(c1, c2, Mesh, data)
%% x-guess
x = zeros(Mesh.nodes_count, 2);
%% a simple initial x-guess
x(Mesh.z1_idx, 1) = linspace(c1, data.sat.x1, Mesh.s1_idx);
x(Mesh.z2_idx, 2) = linspace(c2, data.sat.x2, Mesh.s2_idx);
n = max(Mesh.s1_idx, Mesh.s2_idx);
if(Mesh.s1_idx < Mesh.s2_idx)
    x(Mesh.s1_idx:n, 1) = data.sat.x1;
else
    x(Mesh.s2_idx:n, 2) = data.sat.x2;
end
% concentration in the core
x(n:end, 1) = data.sat.x1;
x(n:end, 2) = data.sat.x2;
end

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