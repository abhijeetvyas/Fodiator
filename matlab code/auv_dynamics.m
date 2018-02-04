function dx = auv_dynamics(t,s)

x=s(1);
y=s(2);
z=s(3);
pie=s(4);
theta=s(5);
si=s(6);

u=s(7);
v=s(8);
w=s(9);
p=s(10);
q=s(11);
r=s(12);

vel=[u; v; w; p; q; r];

J=jacob(s(1:6));
earth_vel=J*s(7:12);

xdot=earth_vel(1);
ydot=earth_vel(2);
zdot=earth_vel(3);
piedot=earth_vel(4);
thetadot=earth_vel(5);
sidot=earth_vel(6);

M_rb=[1462  0      0     0       0        0;
      0     1462   0     0       0        -32.16;
      0     0      1462  0       32.16    0;
      0     0      0     498.63  0        0;
      0     0      32.16 0       1850.34  0;
      0     -32.16 0     0       0        2348.97];
  
M_a=[323.10 0       0       0       0       0;
     0      1049.21 0       0       0       -999.04;
     0      0       7040.36 0       -277.20 0;
     0      0       0       645.85  0       0;
     0      0       -277.20 0       7045.28 0;
     0      -996.04 0       0       0       8584.25];
 
C_rb=[0                0           0           0           32.16*q+1462*w  32.16*r-1462*v;
       0                0           0           -1462*w     -32.16*p        1462*u;
       0                0           0           1462*v      -1462*u         -32.16*p;
       0                1462*w      -1462*v     0           2848.97*r       -1850.34*q;
       -32.16*q-1462*w  32.16*p     1462*u      -2848.97*r  0               498.63*p;
       -32.16*r+1462*v  -1462*u     32.16*p     1850.34*q   -498.63*p       0];
 
C_a= [0                     0                       0                       0                       7040.36*w-277.20*q      -1049.21*v+996.04*r;
      0                     0                       0                       -7040.36*w+277.20*q     0                       323.10*u;
      0                     0                       0                       1049.21*v-996.04*r       -323.10*u               0;
      0                     7040.36*w-277.20*q      -1049.21*v+996.04*r     0                       -996.04*v+8584.25*r     -277.20*w+7045.28*q;
      -7040.36*w+277.20*q   0                       323.10*u                996.04*v-8584.25*r      0                       645.85*p;
      1049.21*v-996.04*r    -323.10*u               0                       -277.20*w+7045.28*q     -645.85*p               0];
  
G=   [-49*sin(theta);
       49*cos(theta)*sin(pie);
       49*cos(theta)*cos(pie);
       215.87*cos(theta)*sin(pie);
       215.87*sin(theta)-1.1*cos(theta)*cos(pie);
       1.1*cos(theta)*sin(pie)];
  
D=  [13.62+32.29*abs(u) -17.20-22.58*abs(v)     28.26+607.6*abs(w)      0       0       0;
     0                  534.9+607.6*abs(v)      0                       0       0       -1381.55;
     0                  0                       1441.25+2859.41*abs(w)  0       2052.86 0;
     0                  0                       0                       2050.3  0       0;
     0                  0                       -3105.27+381.04*abs(w)  0       6497.65 0;
     0                  372.11-1006.48*abs(v)   0                       0       0       1194.31];
 
M=M_rb+M_a;
 
C=C_rb+C_a;

accl=M\([0 0 0 0 0 0]'-(C*vel+D*vel+G));

xddot=accl(1);
yddot=accl(2);
zddot=accl(3);
rollddot=accl(4);
pitchddot=accl(5);
yawddot=accl(6);

dx=[xdot; ydot; zdot; piedot; thetadot; sidot; xddot; yddot; zddot; rollddot; pitchddot; yawddot];

end