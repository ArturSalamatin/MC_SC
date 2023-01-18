
%% init figirues
figure_init;
%% init calculations
regime = 0;
init;
%% plot the phase diagram
phaseDiagram(data);
%% plot Gibbs energy
vicinity = 0.1;
% MU_plotter(vicinity, data);
G_solution(vicinity, data);


c1 = 1E-6;
c2 = 1E-6;
s1 = 1;
s2 = 0.75;
segment = 1;
nodes_count = 4001;

conc_plotter(s1, s2, c1, c2, segment, nodes_count, data);

