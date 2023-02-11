function conc_plotter(s1, s2, c1, c2, nodes_count, data)
global phaseEqId concDistribId muDistribId fluxDistribId
global concDistrib componentsSpecs
%% overall grid
segment = 1; % segment for the problem solution, [0;1]
Mesh = set_mesh(s1, s2, segment, nodes_count);
%% x-guess
x = initial_guess_x(c1, c2, Mesh, data);
%% mu-guess
phi = initial_guess_phi(x, data);
%% get concentration distribution within a particle
[x,phi] = solute_distribution2(x, phi,...
    Mesh, data, c1, c2);
%% plots
% chem.pot. distribution in the particle
% as function of position
if(~isempty(muDistribId))
    figure(muDistribId)
    plot(Mesh.mesh, phi(:,1), ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
    plot(Mesh.mesh, phi(:,2), ...
        componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
end
% concentration distribution in the particle
% as function of position
if(~isempty(concDistribId))
    figure(concDistribId)
    plot(Mesh.mesh, x(:,1), ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
    plot(Mesh.mesh, x(:,2), ...
        componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
end
% flux distribution in the particle
% as function of position
if(~isempty(fluxDistribId))
    
    j = (x(2:end,:)+x(1:(end-1),:))/2.*...
        (phi(2:end,:)-phi(1:(end-1),:))./...
        (Mesh.mesh(2:end)-Mesh.mesh(1:(end-1)))' ...
        ./[data.xSat1,data.xSat2];
    z_mid = (Mesh.mesh(2:end)+Mesh.mesh(1:(end-1)))/2;
    
    figure(fluxDistribId)
    plot(z_mid, j(:,1), ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
    plot(z_mid, j(:,2), ...
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