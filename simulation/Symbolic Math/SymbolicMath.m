
%% Peaucellier Straight-Line Mechanism
clear; clc; close all;

a = 105; b = 40; r = 35;       % Link dimensions (mm)
L = (a^2-b^2)/(2*r);
lim = 2*acos((a-b)/(2*r))-0.01;

omega = 1;                     % rad/s
dt = 0.01;
T = 2*lim/omega;
time = [0:dt:T, T];
theta = -lim + omega*time;

%% Figure
figure('Color','w');
hold on; axis equal; grid on;
xlim([-20 190]); ylim([-120 120]);
xlabel('X (mm)'); ylabel('Y (mm)');

O2 = [0;0]; O3 = [0;0]; O4 = [r;0];
ymax = L*tan(lim/2);

% Ground and output workspace
plot([O2(1) O4(1)],[0 0],'k-','LineWidth',2);
plot([L L],[-ymax ymax],'k--','LineWidth',1.5);

% Extreme positions
plot(L,-ymax,'ro','MarkerFaceColor','r');
plot(L,ymax,'mo','MarkerFaceColor','m');
text(L+5,-ymax,'Lower Extreme');
text(L+5,ymax,'Upper Extreme');

% Output path
pathG = plot(nan,nan,'b-','LineWidth',2);
G_history = nan(2,numel(time));

% Links 2-8
colors = [0 .7 0; 0 .7 0; 1 0 0; zeros(4,2) ones(4,1)];
links = gobjects(1,7);

for i = 1:7
    links(i) = plot(nan,nan,'-o','Color',colors(i,:), ...
        'LineWidth',3,'MarkerFaceColor',colors(i,:));
end

names = {'O_2,O_3','O_4','C,D','A,B','E,F','G'};
labels = gobjects(1,6);

for i = 1:6
    labels(i) = text(nan,nan,names{i},'FontWeight','bold');
end

%% Animation
clockStart = tic;

for k = 1:numel(time)
    t = theta(k);

    CD = [r*(1+cos(t)); r*sin(t)];
    G = [L; L*tan(t/2)];

    M = (CD+G)/2;
    d = norm(G-CD);
    h = sqrt(max(0,b^2-d^2/4));
    u = (G-CD)/d;
    v = [-u(2);u(1)];

    AB = M+h*v;
    EF = M-h*v;

    endpoints = {O2,AB; O3,EF; O4,CD; AB,CD; ...
                 CD,EF; AB,G; EF,G};

    for i = 1:7
        p = endpoints{i,1}; q = endpoints{i,2};
        set(links(i),'XData',[p(1) q(1)], ...
                     'YData',[p(2) q(2)]);
    end

    joints = [O2 O4 CD AB EF G];
    for i = 1:6
        set(labels(i),'Position',[joints(:,i)'+[0 7],0]);
    end

    % Trace point G
    G_history(:,k) = G;
    set(pathG,'XData',G_history(1,1:k), ...
              'YData',G_history(2,1:k));

    title(sprintf('Input = %.1f° | Time = %.2f s', ...
        rad2deg(t),time(k)));

    drawnow;
    pause(max(0,time(k)-toc(clockStart)));
end
%%
%% Workspace and Straight-Line Analysis
t = linspace(-lim,lim,200);
X = L*ones(size(t));
Y = L*tan(t/2);

stroke = 2*ymax;
error = max(abs(X-L));

figure('Color','w','Position',[200 200 1000 400]);

% Workspace and extreme positions
subplot(1,2,1)
plot(X,Y,'b','LineWidth',2)
hold on
plot(L,-ymax,'ro','MarkerFaceColor','r')
plot(L,0,'go','MarkerFaceColor','g')
plot(L,ymax,'mo','MarkerFaceColor','m')

text(L+3,-ymax,sprintf('Lower: %.2f mm',-ymax))
text(L+3,0,'Center: 0 mm')
text(L+3,ymax,sprintf('Upper: %.2f mm',ymax))
text(L+3,25,sprintf('Stroke = %.2f mm',stroke), ...
    'FontWeight','bold')

xlabel('X (mm)')
ylabel('Y (mm)')
title('Workspace and Extreme Positions')
xlim([L-15 L+55])
ylim([-65 65])
grid on

% Output displacement
subplot(1,2,2)
plot(rad2deg(t),Y,'b','LineWidth',1.5)
hold on
plot([-rad2deg(lim) 0 rad2deg(lim)], ...
     [-ymax 0 ymax],'ro','MarkerFaceColor','r')

text(-rad2deg(lim)+2,-ymax+6, ...
    sprintf('(%.1f, %.1f)',-rad2deg(lim),-ymax))
text(2,5,'(0, 0)')
text(rad2deg(lim)-20,ymax-6, ...
    sprintf('(%.1f, %.1f)',rad2deg(lim),ymax))

xlabel('Input Angle (deg)')
ylabel('Y Position (mm)')
title('Output Displacement')
grid on


%% Results
fprintf('Output X = %.2f mm\n',L);
fprintf('Input range = +/- %.2f deg\n',rad2deg(lim));
fprintf('Lower extreme = %.2f mm\n',-ymax);
fprintf('Upper extreme = %.2f mm\n',ymax);
fprintf('Output stroke = %.2f mm\n',stroke);
fprintf('Straight-line error = %.6f mm\n',error);
fprintf('Sweep duration = %.2f s\n',T);