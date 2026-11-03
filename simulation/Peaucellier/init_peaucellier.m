clc; clear all;
% Peaucellier-Lipkin
% All is SI Units (m,kg/m^3)
width = 0.010;
thickness = 0.004;
lho = 1000;

% Coordinate [x y z] in SI Units
O4 = [0.035 0 0];

% Length
L4 = 0.035;
L23 = 0.105;
L5678 = 0.040;

% Appearance L{Number}_CS (Cross section)
L4_CS = peaucellier_capsule_profile(L4, width);
L23_CS = peaucellier_capsule_profile(L23, width);
L5678_CS = peaucellier_capsule_profile(L5678, width);

% Motion Range
T=8; 
amplitude=pi/6; 
omega=2*pi/T;
freq = 1/T;