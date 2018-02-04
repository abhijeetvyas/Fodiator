function J = jacob(eta)

phi=eta(4,1);
theta=eta(5,1);
si=eta(6,1);

c_p=cos(phi);
c_t=cos(theta);
c_s=cos(si);
s_p=sin(phi);
s_t=sin(theta);
s_s=sin(si);
t_t=tan(theta);


J1=[c_s*c_t    -s_s*c_p+s_p*s_t*c_s     s_s*s_p+s_t*c_s*c_p;
    s_s*c_t     c_s*c_p+s_p*s_t*s_s    -c_s*s_p+s_t*s_s*c_p;
     -s_t            s_p*c_t                 c_p*c_t       ];
       
J2=[1      s_p*t_t     c_p*t_t;
    0        c_p        -s_p;
    0      s_p/c_t     c_p/c_t ];


J=[J1 zeros(3,3); zeros(3,3) J2];

end