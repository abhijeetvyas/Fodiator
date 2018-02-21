clear all
close all
clc


deg_to_rad = pi/180;   
rad_to_deg = 180/pi;

load('alpha_Cd_Cl.mat');
load('Thrust_PWM.mat');

sim('trial.slx',[0 1000]);
%%
input = simout.Data(:,1:6);
q=simout.Data(:,1:12);
t=simout.Time;
subplot(3,2,1),plot(t,q(:,1));
grid on
title('\fontsize{14} X');
xlabel('Time(s)');
ylabel('x');

subplot(3,2,3),plot(t,q(:,2));
grid on
title('\fontsize{14} Y');
xlabel('Time (s)');
ylabel('y');

subplot(3,2,5),plot(t,q(:,3));
grid on
title('\fontsize{14} Z');
xlabel('Time(s)');
ylabel('z');

subplot(3,2,2),plot(t,q(:,7));
grid on
title('\fontsize{14} Surge');
xlabel('Time(s)');
ylabel('Surge');

subplot(3,2,4),plot(t,q(:,8));
grid on
title('\fontsize{14} Sway');
xlabel('Time(s)');
ylabel('Sway');

subplot(3,2,6),plot(t,q(:,9));
grid on
title('\fontsize{14} Heave');
xlabel('Time(s)');
ylabel('Heave');

figure

subplot(3,2,1),plot(t,q(:,4)*rad_to_deg);
grid on
title('\fontsize{14} Roll');
xlabel('Time(s)');
ylabel('Phi');

subplot(3,2,3),plot(t,q(:,5)*rad_to_deg);
grid on
title('\fontsize{14} Pitch');
xlabel('Time(s)');
ylabel('Theta');

subplot(3,2,5),plot(t,q(:,6)*rad_to_deg);
grid on
title('\fontsize{14} Yaw');
xlabel('Time(s)');
ylabel('Psi');

subplot(3,2,2),plot(t,q(:,10)*rad_to_deg);
grid on
title('\fontsize{14} Rolldot');
xlabel('Time(s)');
ylabel('Phidot');

subplot(3,2,4),plot(t,q(:,11)*rad_to_deg);
grid on
title('\fontsize{14} Pitchdot');
xlabel('Time(s)');
ylabel('Thetadot');

subplot(3,2,6),plot(t,q(:,12)*rad_to_deg);
grid on
title('\fontsize{14} Yawdot');
xlabel('Time(s)');
ylabel('Psidot');
%%
%figure
%final_plot(t,q(:,1:6))
% plot_ganesh(t,q(:,1:6))


