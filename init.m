clc
close all
clear all

global lw
lw = 2;
fntSize = 14;
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', fntSize);
set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultTextFontSize', fntSize)

g1 = -5;
g2 = 15;

xSat1 = 1/500;
xSat2 = 1/500;

omega1 = -(g1+log(xSat1))/((1-xSat1)^2);
omega2 = -(g2+log(xSat2))/((1-xSat2)^2);
omega12 = -180;%5.5;
% omega12 = 3.587; % max saturation

data = struct(...
    'g1', g1, 'g2', g2, ...
    'xSat1', xSat1, 'xSat2', xSat2, ...
    'omega1', omega1, 'omega2', omega2, 'omega12', omega12);
[X1_sat, X2_sat, X3_sat] = phaseDiagram(data);
data.sat = struct('x1', X1_sat, 'x2', X2_sat);