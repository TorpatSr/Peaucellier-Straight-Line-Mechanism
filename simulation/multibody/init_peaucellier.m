clc; clear all;
% Peaucellier-Lipkin
% All is SI Units (m,kg/m^3)
width = 0.010;
thickness = 0.010;
lho = 1000;

% Coordinate [x y z] in SI Units
O4 = [0.035 0 0];

% Length
L4 = 0.035;
L23 = 0.105;
L5678 = 0.040;

mode = 0; % 0 for linear input, 1 for sin input
amplitude = 43.00*pi/180;

% Sin mode
T=8; 
omega=2*pi/T;
freq = 1/T;

% Linear mode
crankRate = 1;                 % Angular velocity (rad/s)
T = 2 * amplitude / crankRate; % Time form -30° to +30° (s)

%% Appearance L{Number}_CS (Cross section)
% L4_CS = peaucellier_capsule_profile(L4, width);
% L23_CS = peaucellier_capsule_profile(L23, width);
% L5678_CS = peaucellier_capsule_profile(L5678, width);

% Initial joint position targets (rad)
qCrank0 = -amplitude;
crankTip0 = O4(1:2) + L4 * [cos(qCrank0), sin(qCrank0)];
r = norm(crankTip0);
if r <= abs(L23 - L5678) || r >= L23 + L5678
    error('Initial crank angle gives a singular or infeasible linkage pose.');
end

phi = atan2(crankTip0(2), crankTip0(1));
delta = acos((L23^2 + r^2 - L5678^2) / (2 * L23 * r));

qO2_init = phi + delta;
qO3_init = phi - delta;