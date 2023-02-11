close all
clc
clear all
%% simulations for tpycal equilibrium values
for regime = 1:4
    %% init figirues
    figure_init;
    %% init calculations
    init;
    %% plot the phase diagram
    phaseDiagram(data);
    %% plot Gibbs energy
    vicinity = 0.1;
    % MU_plotter(vicinity, data);
    G_solution(vicinity, data);
    
    c1 = 1E-7;
    c2 = 1E-7;
    s1 = 1;
    s2 = 0.5;
    nodes_count = 2001;
    
    conc_plotter(s1, s2, c1, c2, nodes_count, data);
    flux_plotter(c1, c2, nodes_count, data);
    
    figure(concDistribId)
end
% %% generates Figure 6 of the manuscript
% for regime = -5:0
%     %% init figirues
%     figure_init;
%     %% init calculations
%     init;
%     %% plot the phase diagram
%     phaseDiagram(data);
%     %% plot Gibbs energy
%     vicinity = 0.1;
%     % MU_plotter(vicinity, data);
%     G_solution(vicinity, data);
%     
%     
%     c1 = 1E-6;
%     c2 = 1E-6;
%     s1 = 1;
%     s2 = 0.5;
%     segment = 1;
%     nodes_count = 4001;
%     
%     conc_plotter(s1, s2, c1, c2, segment, nodes_count, data);
%     
%     figure(concDistribId)
% end

%% simplified approach
    conc_plotter_simple(s1, s2, c1, c2, nodes_count, data);
    figure(concDistribId)


