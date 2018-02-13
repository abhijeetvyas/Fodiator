clear all
close all
clc

% global dia
% global rad
% global height
% global vol
% global m
% global rho_water
% global rho_cyl
% global W
% global B
% global cg
% global cb 
% global store_count
% global forces
% global q0

store_count=0;

dia=0.15;                    %Diameter
rad=dia/2;                   %Radius
height=0.3;                  %Height
vol=pi*(rad^2)*height       %Volume
rho_water=1000;              %Density of water
Orig_B=vol*rho_water*9.8;         %Buoyancy
W=Orig_B
%m=100.531;                  %mass
m = W/9.8                   %Weight
percent_change_in_B = 0;
B = Orig_B+(percent_change_in_B/100*Orig_B)
New_vol = B/(rho_water*9.8)
Change_in_vol = abs(vol - New_vol)
New_height = New_vol/(pi*(rad^2))
Change_in_height = abs(New_height - height)


rho_cyl=m/vol;              %Density of cylinder

cg=[0 0  0.1];                 %Centre of Gravity
cb=[0 0  -0.1];                 %Centre of Buoyancy

deg_to_rad = pi/180;   
rad_to_deg = 180/pi;

q0=[10 10 10 10*deg_to_rad 0*deg_to_rad 0*deg_to_rad 0 0 0 0*deg_to_rad 0*deg_to_rad 0*deg_to_rad];

sim('cyl_sim')

t=tim;
out=q;

subplot(3,2,1),plot(t,out(:,1));
grid on
title('\fontsize{14} X');
xlabel('Time(s)');
ylabel('X');

subplot(3,2,3),plot(t,out(:,2));
grid on
title('\fontsize{14} Y');
xlabel('Time (s)');
ylabel('Y');

subplot(3,2,5),plot(t,out(:,3));
grid on
title('\fontsize{14} Z');
xlabel('Time(s)');
ylabel('Z');

subplot(3,2,2),plot(t,out(:,7));
grid on
title('\fontsize{14} Xdot');
xlabel('Time(s)');
ylabel('Xdot');

subplot(3,2,4),plot(t,out(:,8));
grid on
title('\fontsize{14} Ydot');
xlabel('Time(s)');
ylabel('Ydot');

subplot(3,2,6),plot(t,out(:,9));
grid on
title('\fontsize{14} Zdot');
xlabel('Time(s)');
ylabel('Heave');

figure

subplot(3,2,1),plot(t,out(:,4)*rad_to_deg);
grid on
title('\fontsize{14} Roll');
xlabel('Time(s)');
ylabel('Phi');

subplot(3,2,3),plot(t,out(:,5)*rad_to_deg);
grid on
title('\fontsize{14} Pitch');
xlabel('Time(s)');
ylabel('Theta');

subplot(3,2,5),plot(t,out(:,6)*rad_to_deg);
grid on
title('\fontsize{14} Yaw');
xlabel('Time(s)');
ylabel('Psi');

subplot(3,2,2),plot(t,out(:,10)*rad_to_deg);
grid on
title('\fontsize{14} Rolldot');
xlabel('Time(s)');
ylabel('Phidot');

subplot(3,2,4),plot(t,out(:,11)*rad_to_deg);
grid on
title('\fontsize{14} Pitchdot');
xlabel('Time(s)');
ylabel('Thetadot');

subplot(3,2,6),plot(t,out(:,12)*rad_to_deg);
grid on
title('\fontsize{14} Yawdot');
xlabel('Time(s)');
ylabel('Psidot');

figure

subplot(3,2,2),plot(t,forces(:,1));
grid on
title('\fontsize{14} Force in X');
xlabel('Time(s)');
ylabel('X_Force');

subplot(3,2,4),plot(t,forces(:,2));
grid on
title('\fontsize{14} Force in Y');
xlabel('Time(s)');
ylabel('Y_Force');

subplot(3,2,6),plot(t,forces(:,3));
grid on
title('\fontsize{14} Forces in Z');
xlabel('Time(s)');
ylabel('Z_Force');

subplot(3,2,1),plot(t,body_vel(:,1));
grid on
title('\fontsize{14} Surge velocity');
xlabel('Time(s)');
ylabel('u');

subplot(3,2,3),plot(t,body_vel(:,2));
grid on
title('\fontsize{14} Sway velocity');
xlabel('Time(s)');
ylabel('v');

subplot(3,2,5),plot(t,body_vel(:,3));
grid on
title('\fontsize{14} Heave velocity');
xlabel('Time(s)');
ylabel('w');

% figure
% 
% subplot(3,1,1),plot(t,damping_force(:,1));
% grid on
% title('\fontsize{14} Force in X');
% xlabel('Time(s)');
% ylabel('X_Force');
% 
% subplot(3,1,2),plot(t,damping_force(:,2));
% grid on
% title('\fontsize{14} Force in Y');
% xlabel('Time(s)');
% ylabel('Y_Force');
% 
% subplot(3,1,3),plot(t,damping_force(:,3));
% grid on
% title('\fontsize{14} Forces in Z');
% xlabel('Time(s)');
% ylabel('Z_Force');

figure
final_plot_cyl(t,out(:,1:6),rad,height,cg,cb,15,0.01,1)