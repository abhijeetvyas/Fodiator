%%

clear all;
close all;
clc
a = 20;
load('alpha_Cd_Cl.mat');
load('Thrust_PWM.mat');

deg_to_rad = pi/180;   
rad_to_deg = 180/pi;

sim('Fodiator_model.slx',[0 100]);
%%
%Live plotter
plotter(1)=figure('Name','Live Plotter','NumberTitle','off');
sz_positiondata=size(etapos.Data);
sz_tout = size(tout);
x1 = etapos.Data(:,1);
y1 = etapos.Data(:,2);
z1 = etapos.Data(:,3);

phi=etapos.Data(:,4);
theta=etapos.Data(:,5);
si=etapos.Data(:,6);

dimension=1;

x_range=abs(min(etapos.Data(:,1)))+abs(max(etapos.Data(:,1)));
y_range=abs(min(etapos.Data(:,2)))+abs(max(etapos.Data(:,2)));

if x_range>=y_range
    axis([min(x1)-a*dimension max(x1)+a*dimension min(x1)-a*dimension max(x1)+a*dimension min(z1)-a*dimension max(z1)+a*dimension])
else
    axis([min(y1)-a*dimension max(y1)+a*dimension min(y1)-a*dimension max(y1)+a*dimension min(z1)-a*dimension max(z1)+a*dimension])
end

grid on;box on;
title('\fontsize{16} Pose of the system')
xlabel('X(m)');ylabel('Y(m)');zlabel('Z(m)')
set(gca,'zdir','reverse')
hold on

no_of_points=7;

x=[ 1.25*dimension  dimension 0;
   -1.25*dimension  dimension 0;
   -dimension-dimension  dimension-0.35*dimension 0;
   -dimension-dimension -dimension+0.35*dimension 0;
   -1.25*dimension -dimension 0;
    1.25*dimension -dimension 0;
    dimension+0.75*dimension 0 0];
pause(2);
for count=1:sz_positiondata(1)

c_p=cos(phi(count));
c_t=cos(theta(count));
c_s=cos(si(count));
s_p=sin(phi(count));
s_t=sin(theta(count));
s_s=sin(si(count));
t_t=tan(theta(count));
         
  J1=[c_s*c_t    -s_s*c_p+s_p*s_t*c_s     s_s*s_p+s_t*c_s*c_p;
      s_s*c_t     c_s*c_p+s_p*s_t*s_s    -c_s*s_p+s_t*s_s*c_p;
       -s_t            s_p*c_t                 c_p*c_t       ];

for i=1:no_of_points
    pt(i,:)=J1*x(i,:)';
end

    
    trans_mat=[1 0 0 x1(count); 0 1 0 y1(count); 0 0 1 z1(count); 0 0 0 1];
    
    for i=1:no_of_points
     rot_mat=[J1 pt(i,:)'; [0 0 0 1] ];
     fin_mat=trans_mat*rot_mat;
     final_pt(i,:)=[fin_mat(1,4) fin_mat(2,4) fin_mat(3,4)];
    end
    
    yy=plot3(final_pt(:,1),final_pt(:,2),final_pt(:,3),'b*');
    xx=plot3(x1(count),y1(count),z1(count),'r.');
    
    for i=1:no_of_points-1
           aa(i) = line([final_pt(i,1) final_pt(i+1,1)], [final_pt(i,2) final_pt(i+1,2)], [final_pt(i,3) final_pt(i+1,3)]);
    end
    jj=line([final_pt(1,1) final_pt(i+1,1)], [final_pt(1,2) final_pt(i+1,2)], [final_pt(1,3) final_pt(i+1,3)]);
    
pause(0.2);
    
if count<sz_positiondata(1)
    delete(jj)
    delete(yy)
    for i=1:no_of_points-1
        delete(aa(i))
    end
end
       
end

%%

plotter(2)=figure('Name','Eta','NumberTitle','off');
inputdata = etapos.Data(:,1:6);
t=etapos.Time;

subplot(3,2,1),plot(t,inputdata(:,1));
grid on
title('\fontsize{10} Xpos');
xlabel('Time(s)');
ylabel('Xpos');

subplot(3,2,3),plot(t,inputdata(:,2));
grid on
title('\fontsize{10} Ypos');
xlabel('Time(s)');
ylabel('Ypos');

subplot(3,2,5),plot(t,inputdata(:,3));
grid on
title('\fontsize{10} Zpos');
xlabel('Time(s)');
ylabel('Zpos');

subplot(3,2,2),plot(t,rad_to_deg*inputdata(:,4));
grid on
title('\fontsize{10} Rollangle degree');
xlabel('Time(s)');
ylabel('Rollangle');

subplot(3,2,4),plot(t,rad_to_deg*inputdata(:,5));
grid on
title('\fontsize{10} Pitchangle degree');
xlabel('Time(s)');
ylabel('Pitchangle');

subplot(3,2,6),plot(t,rad_to_deg*inputdata(:,6));
grid on
title('\fontsize{10} Yawangle degree');
xlabel('Time(s)');
ylabel('Yawangle');


%%

plotter(3)=figure('Name','EtaDot','NumberTitle','off');
inputdata = etadot.Data(:,1:6);
t=etadot.Time;

subplot(3,2,1),plot(t,inputdata(:,1));
grid on
title('\fontsize{10} Xdot');
xlabel('Time(s)');
ylabel('Xdot');

subplot(3,2,3),plot(t,inputdata(:,2));
grid on
title('\fontsize{10} Ydot');
xlabel('Time(s)');hold off
ylabel('Ydot');

subplot(3,2,5),plot(t,inputdata(:,3));
grid on
title('\fontsize{10} Zdot');
xlabel('Time(s)');
ylabel('Zdot');

subplot(3,2,2),plot(t,inputdata(:,4));
grid on
title('\fontsize{10} Rolldot');
xlabel('Time(s)');
ylabel('Rolldot');

subplot(3,2,4),plot(t,inputdata(:,5));
grid on
title('\fontsize{10} Pitchdot');
xlabel('Time(s)');
ylabel('Rolldot');

subplot(3,2,6),plot(t,inputdata(:,6));
grid on
title('\fontsize{10} Yawdot');
xlabel('Time(s)');
ylabel('Yawdot');

%%

plotter(4)=figure('Name','BodyVel','NumberTitle','off');
inputdata = vel.Data(:,1:6);
t=vel.Time;

subplot(3,2,1),plot(t,inputdata(:,1));
grid on
title('\fontsize{10} u');
xlabel('Time(s)');
ylabel('u');

subplot(3,2,3),plot(t,inputdata(:,2));
grid on
title('\fontsize{10} v');
xlabel('Time(s)');
ylabel('v');

subplot(3,2,5),plot(t,inputdata(:,3));
grid on
title('\fontsize{10} w');
xlabel('Time(s)');
ylabel('w');

subplot(3,2,2),plot(t,inputdata(:,4));
grid on
title('\fontsize{10} p');
xlabel('Time(s)');
ylabel('p');

subplot(3,2,4),plot(t,inputdata(:,5));
grid on
title('\fontsize{10} q');
xlabel('Time(s)');
ylabel('q');

subplot(3,2,6),plot(t,inputdata(:,6));
grid on
title('\fontsize{10} r');
xlabel('Time(s)');
ylabel('r');


%%

plotter(5)=figure('Name','HullForce','NumberTitle','off');
inputdata = bodyforce.Data(:,1:6);
t=bodyforce.Time;

subplot(3,2,1),plot(t,inputdata(:,1));
grid on
title('\fontsize{10} Hull Fx');
xlabel('Time(s)');
ylabel('Hull Fx');

subplot(3,2,3),plot(t,inputdata(:,2));
grid on
title('\fontsize{10} Hull Fy');
xlabel('Time(s)');
ylabel('Hull Fy');

subplot(3,2,5),plot(t,inputdata(:,3));
grid on
title('\fontsize{10} Hull Fz');
xlabel('Time(s)');
ylabel('Hull Fz');

subplot(3,2,2),plot(t,inputdata(:,4));
grid on
title('\fontsize{10} Hull Roll Moment');
xlabel('Time(s)');
ylabel('Hull Mx ');

subplot(3,2,4),plot(t,inputdata(:,5));
grid on
title('\fontsize{10} Hull Pitch Moment');
xlabel('Time(s)');
ylabel('Hull My ');

subplot(3,2,6),plot(t,inputdata(:,6));
grid on
title('\fontsize{10} Hull Yaw Moment');
xlabel('Time(s)');
ylabel('Hull Mz ');

%%

plotter(6)=figure('Name','External Force(CP & Thruster)','NumberTitle','off');
inputdata = extforce.Data(:,1:6);
t=extforce.Time;

subplot(3,2,1),plot(t,inputdata(:,1));
grid on
title('\fontsize{10} Ext Fx');
xlabel('Time(s)');
ylabel('Ext Fx');

subplot(3,2,3),plot(t,inputdata(:,2));
grid on
title('\fontsize{10} Ext Fy');
xlabel('Time(s)');
ylabel('Ext Fy');

subplot(3,2,5),plot(t,inputdata(:,3));
grid on
title('\fontsize{10} Ext Fz');
xlabel('Time(s)');
ylabel('Ext Fz');

subplot(3,2,2),plot(t,inputdata(:,4));
grid on
title('\fontsize{10} Ext Roll Moment');
xlabel('Time(s)');
ylabel('Ext Mx ');

subplot(3,2,4),plot(t,inputdata(:,5));
grid on
title('\fontsize{10} Ext Pitch Moment');
xlabel('Time(s)');
ylabel('Ext My ');

subplot(3,2,6),plot(t,inputdata(:,6));
grid on
title('\fontsize{10} Ext Yaw Moment');
xlabel('Time(s)');
ylabel('Ext Mz ');


%%

plotter(7)=figure('Name','Net Force','NumberTitle','off');
inputdata = netforce.Data(:,1:6);
t=netforce.Time;

subplot(3,2,1),plot(t,inputdata(:,1));
grid on
title('\fontsize{10} Net Fx');
xlabel('Time(s)');
ylabel('Net Fx');

subplot(3,2,3),plot(t,inputdata(:,2));
grid on
title('\fontsize{10} Net Fy');
xlabel('Time(s)');
ylabel('Net Fy');

subplot(3,2,5),plot(t,inputdata(:,3));
grid on
title('\fontsize{10} Net Fz');
xlabel('Time(s)');
ylabel('Net Fz');

subplot(3,2,2),plot(t,inputdata(:,4));
grid on
title('\fontsize{10} Net Roll Moment');
xlabel('Time(s)');
ylabel('Net Mx ');

subplot(3,2,4),plot(t,inputdata(:,5));
grid on
title('\fontsize{10} Net Pitch Moment');
xlabel('Time(s)');
ylabel('Net My ');

subplot(3,2,6),plot(t,inputdata(:,6));
grid on
title('\fontsize{10} Net Yaw Moment');
xlabel('Time(s)');
ylabel('Net Mz ');

%%

plotter(8)=figure('Name','Net Force Abs Frame','NumberTitle','off');
inputdata = netforce_AbsFrame.Data(:,1:6);
t=netforce.Time;

subplot(3,2,1),plot(t,inputdata(:,1));
grid on
title('\fontsize{10} Net Fx');
xlabel('Time(s)');
ylabel('Net Fx');

subplot(3,2,3),plot(t,inputdata(:,2));
grid on
title('\fontsize{10} Net Fy');
xlabel('Time(s)');
ylabel('Net Fy');

subplot(3,2,5),plot(t,inputdata(:,3));
grid on
title('\fontsize{10} Net Fz');
xlabel('Time(s)');
ylabel('Net Fz');

subplot(3,2,2),plot(t,inputdata(:,4));
grid on
title('\fontsize{10} Net Roll Moment');
xlabel('Time(s)');
ylabel('Net Mx ');

subplot(3,2,4),plot(t,inputdata(:,5));
grid on
title('\fontsize{10} Net Pitch Moment');
xlabel('Time(s)');
ylabel('Net My ');

subplot(3,2,6),plot(t,inputdata(:,6));
grid on
title('\fontsize{10} Net Yaw Moment');
xlabel('Time(s)');
ylabel('Net Mz ');

