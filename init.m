%% some more or less realistic regime
if(regime == 4)
%% dissolution energy of oil component in the solvent
g1 = 0; %-5;
g2 = 0; %15;
%% two-phase equilibrium solution concentrations
xSat1 = 1/500;
xSat2 = 1/500;
%% parameters of regular solution
omega1 = -(g1+log(xSat1))/((1-xSat1)^2)
omega2 = -(g2+log(xSat2))/((1-xSat2)^2)
omega12 = -120;
% omega12 = 3.587; % max saturation
end%% some more or less realistic regime%% some more or less realistic regime

if(regime == 3)
%% dissolution energy of oil component in the solvent
g1 = 0; %-5;
g2 = 0; %15;
%% two-phase equilibrium solution concentrations
xSat1 = 1/500;
xSat2 = 1/500;
%% parameters of regular solution
omega1 = -(g1+log(xSat1))/((1-xSat1)^2);
omega2 = -(g2+log(xSat2))/((1-xSat2)^2);
omega12 = 0;
% omega12 = 3.587; % max saturation
end%% some more or less realistic regime

%% some more or less realistic regime
if(regime == 2)
%% dissolution energy of oil component in the solvent
g1 = 0; %-5;
g2 = 0; %15;
%% two-phase equilibrium solution concentrations
xSat1 = 1/500;
xSat2 = 1/500;
%% parameters of regular solution
omega1 = -(g1+log(xSat1))/((1-xSat1)^2);
omega2 = -(g2+log(xSat2))/((1-xSat2)^2);
omega12 = 440;
% omega12 = 3.587; % max saturation
end%% some more or less realistic regime

if(regime == 1)
%% dissolution energy of oil component in the solvent
g1 = 0; %-5;
g2 = 0; %15;
%% two-phase equilibrium solution concentrations
xSat1 = 1/500;
xSat2 = 1/500;
%% parameters of regular solution
omega1 = -(g1+log(xSat1))/((1-xSat1)^2);
omega2 = -(g2+log(xSat2))/((1-xSat2)^2);
omega12 = -164.5;
% omega12 = 3.587; % max saturation
end

%% non-realistic regime from the manuscript
if(regime == 0)
%% dissolution energy of oil component in the solvent
g1 = 0;
g2 = 0;
%% two-phase equilibrium solution concentrations
xSat1 = 1/10;
xSat2 = 1/10;
%% parameters of regular solution
omega1 = -(g1+log(xSat1))/((1-xSat1)^2);
omega2 = -(g2+log(xSat2))/((1-xSat2)^2);
omega12 = 3.6;%5.5;
% omega12 = 3.587; % max saturation
end
%% non-realistic regime from the manuscript
if(regime == -1)
%% dissolution energy of oil component in the solvent
g1 = 0;
g2 = 0;
%% two-phase equilibrium solution concentrations
xSat1 = 1/10;
xSat2 = 1/10;
%% parameters of regular solution
omega1 = -(g1+log(xSat1))/((1-xSat1)^2);
omega2 = -(g2+log(xSat2))/((1-xSat2)^2);
omega12 = 4;%5.5;
% omega12 = 3.587; % max saturation
end
%% non-realistic regime from the manuscript
if(regime == -2)
%% dissolution energy of oil component in the solvent
g1 = 0;
g2 = 0;
%% two-phase equilibrium solution concentrations
xSat1 = 1/10;
xSat2 = 1/10;
%% parameters of regular solution
omega1 = -(g1+log(xSat1))/((1-xSat1)^2);
omega2 = -(g2+log(xSat2))/((1-xSat2)^2);
omega12 = 6;%5.5;
% omega12 = 3.587; % max saturation
end
%% non-realistic regime from the manuscript
if(regime == -3)
%% dissolution energy of oil component in the solvent
g1 = 0;
g2 = 0;
%% two-phase equilibrium solution concentrations
xSat1 = 1/10;
xSat2 = 1/10;
%% parameters of regular solution
omega1 = -(g1+log(xSat1))/((1-xSat1)^2);
omega2 = -(g2+log(xSat2))/((1-xSat2)^2);
omega12 = 6;%5.5;
% omega12 = 3.587; % max saturation
end
%% non-realistic regime from the manuscript
if(regime == -4)
%% dissolution energy of oil component in the solvent
g1 = 0;
g2 = 0;
%% two-phase equilibrium solution concentrations
xSat1 = 1/10;
xSat2 = 1/10;
%% parameters of regular solution
omega1 = -(g1+log(xSat1))/((1-xSat1)^2);
omega2 = -(g2+log(xSat2))/((1-xSat2)^2);
omega12 = 10;%5.5;
% omega12 = 3.587; % max saturation
end
%% non-realistic regime from the manuscript
if(regime == -5)
%% dissolution energy of oil component in the solvent
g1 = 0;
g2 = 0;
%% two-phase equilibrium solution concentrations
xSat1 = 1/10;
xSat2 = 1/10;
%% parameters of regular solution
omega1 = -(g1+log(xSat1))/((1-xSat1)^2);
omega2 = -(g2+log(xSat2))/((1-xSat2)^2);
omega12 = 25;%5.5;
% omega12 = 3.587; % max saturation
end


%% overall data structure
data = struct(...
    'g1', g1, 'g2', g2, ...
    'xSat1', xSat1, 'xSat2', xSat2, ...
    'omega1', omega1, 'omega2', omega2, 'omega12', omega12);
%% get phase diagram in three-phase equilibrium parameters
[data,X1_sat, X2_sat, ~] = phase3equilib(data);