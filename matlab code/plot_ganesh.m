function final_plot(t,input)

sz_input=size(input);

x1=input(:,1);
y1=input(:,2);
z1=input(:,3);

phi=input(:,4);
theta=input(:,5);
si=input(:,6);

dimension=5;

x_range=abs(min(input(:,1)))+abs(max(input(:,1)));
y_range=abs(min(input(:,2)))+abs(max(input(:,2)));

if x_range>=y_range
    axis([min(x1)-3*dimension max(x1)+3*dimension min(x1)-3*dimension max(x1)+3*dimension min(z1)-3*dimension max(z1)+3*dimension])
else
    axis([min(y1)-3*dimension max(y1)+3*dimension min(y1)-3*dimension max(y1)+3*dimension min(z1)-3*dimension max(z1)+3*dimension])
end

grid on;box on;
title('\fontsize{16} Pose of the system')
xlabel('X(m)');ylabel('Y(m)');zlabel('Z(m)')
set(gca,'zdir','reverse')
hold on

no_of_points=4;

x=[ dimension  dimension 0;
   dimension  dimension 0;
   -dimension  dimension 0;
   -dimension -dimension 0];

for count=1:sz_input(1)

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
    
pause(0.1)
    
if count<sz_input(1)
    delete(jj)
    delete(yy)
    for i=1:no_of_points-1
        delete(aa(i))
    end
end
       
end


end
            

            
            
            