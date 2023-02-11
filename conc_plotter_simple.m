function conc_plotter_simple(s1, s2, c1, c2, nodes_count, data)
% this function plots the solute distribution according to a 
% simple model that does not take into account components
% interactions
global concDistribId fluxDistribId
global componentsSpecs
segment = 1;
Mesh = set_mesh(s1, s2, segment, nodes_count);
%% x-guess
x = zeros(nodes_count, 2);
%% a simple initial x-guess
x(Mesh.s1_idx:end, 1) = data.xSat1; 
x(Mesh.s2_idx:end, 2) = data.xSat2;
x(Mesh.z1_idx, 1) = linspace(c1, data.xSat1, s1_idx);
x(Mesh.z2_idx, 2) = linspace(c2, data.xSat2, s2_idx);
%% plots
% concentration distribution in the particle
% as function of position
if(~isempty(concDistribId))
    figure(concDistribId)
    plot(Mesh.mesh, x(:,1), ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw, ...
        'LineStyle', '--')
    plot(Mesh.mesh, x(:,2), ...
        componentsSpecs.color2, 'LineWidth', componentsSpecs.lw, ...
        'LineStyle', '--')
end
% flux distribution in the particle
% as function of position
if(~isempty(fluxDistribId))
    z_mid = (Mesh.mesh(2:end)+Mesh.mesh(1:(end-1)))/2;
    
    figure(fluxDistribId)
    plot(z_mid, 1*ones(size(z_mid)), ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw, ...
        'LineStyle', '--')
    plot(z_mid, Mesh.s1/Mesh.s2*ones(size(z_mid)), ...
        componentsSpecs.color2, 'LineWidth', componentsSpecs.lw, ...
        'LineStyle', '--')
end
end