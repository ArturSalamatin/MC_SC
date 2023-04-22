function flux_plotter(c1, c2, nodes_count, data)
global flux1_PlotId flux2_PlotId fluxFrac_PlotId fluxSum_PlotId  
global componentsSpecs

segment = 1;
S1 = 1; % spatial scale
S2 = linspace(0, 1, min(301, nodes_count)); % s2/s1-ratio for flux-plot abscissa
S2(1:4) = [];

J1 = zeros(size(S2));
J2 = zeros(size(S2));

x = initial_guess_x(...
    c1, c2, ...
    set_mesh(S1, S2(1), segment, nodes_count), ...
    data);
phi = initial_guess_phi(x, data);

for i = 1:length(S2)
    s1 = S1;
    s2 = S2(i);
    %% overall grid
    Mesh = set_mesh(s1, s2, segment, nodes_count);
    %% get concentration distribution within a particle
    [x,phi] = solute_distribution2(x, phi,...
        Mesh, data, c1, c2);
    % flux distribution in the particle
    % as function of position
    
    j = (x(1+1,:)+x(1,:))/2.*...
        (phi(1+1,:)-phi(1,:))./...
        (Mesh.mesh(1+1)-Mesh.mesh(1))' ...
        ./[data.xSat1,data.xSat2];
    J1(i) = j(1);
    J2(i) = j(2);
    
    S2(i) = Mesh.s2;
    
    % concentration distribution in the particle
    % as function of position
    % if(~isempty(concDistribId))
    %     figure(concDistribId-2)
    %     hold on
    %     axis([0 1 0 Inf])
    %     plot(mesh, x(:,1), ...
    %         componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
    %     plot(mesh, x(:,2), ...
    %         componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
    % end
    
    
end

%% plots
% concentration distribution in the particle
% as function of position
if(~isempty(flux1_PlotId))
    figure(flux1_PlotId)
    plot(S2, J1, ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
end
if(~isempty(flux2_PlotId))
    figure(flux2_PlotId)
    plot(S2, J2.*S2, ...
        componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
end
if(~isempty(fluxSum_PlotId))
    figure(fluxSum_PlotId)
    plot(S2, (J1+J2)./(1+1./S2), ...
        'Color', 'black', 'LineWidth', componentsSpecs.lw)
end
if(~isempty(fluxFrac_PlotId))
    figure(fluxFrac_PlotId)
    plot(S2, J1./(J1+J2), ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
    plot(S2, J2./(J1+J2), ...
        componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
end

end

