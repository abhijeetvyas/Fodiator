function final_plot_cyl(t,input,rad,height,cg,cb,no_points,speed,inter)

sz_input=size(input);

x1=input(:,1);
y1=input(:,2);
z1=-input(:,3);

phi=input(:,4);
theta=input(:,5);
si=input(:,6);

scale=80;

r=rad*scale;
h=height*scale;
cg=cg*scale;
cb=cb*scale;

no_of_points=2*no_points;

x_range=abs(min(x1))+abs(max(x1));
y_range=abs(min(y1))+abs(max(y1));
z_range=abs(min(z1))+abs(max(z1));


[unused, index] = max([x_range y_range z_range]);
% if x_range>=y_range
%     axis([min(x1)-2*h max(x1)+2*h min(x1)-2*h max(x1)+2*h min(z1)-2*h max(z1)+2*h])
% else
%     axis([min(y1)-2*h max(y1)+2*h min(y1)-2*h max(y1)+2*h min(z1)-2*h max(z1)+2*h])
% end

% if x_range>=y_range
%     axis([min(x1)-40 max(x1)+40 min(x1)-40 max(x1)+40 min(z1)-40 max(z1)+40])
% else
%     axis([min(y1)-40 max(y1)+40 min(y1)-40 max(y1)+40 min(z1)-40 max(z1)+40])
% end

if index==1
    axis([min(x1)-h max(x1)+h min(x1)-h max(x1)+h min(x1)-h max(x1)+h])
elseif index==2
    axis([min(y1)-h max(y1)+h min(y1)-h max(y1)+h min(y1)-h max(y1)+h])
else
    axis([min(z1)-h max(z1)+h min(z1)-h max(z1)+h min(z1)-h max(z1)+h])
end

grid on;
box on;
title('\fontsize{16} Pose of the system')
xlabel('X(m)');ylabel('Y(m)');zlabel('Z(m)')
% set(gca,'zdir','reverse')
hold on

ang=2*pi/no_points;

x=zeros(2*no_points,3);

for i=1:no_points
    x(i,:) = [r*cos(i*ang) r*sin(i*ang) -h/2];
end
  
for j=1:no_points
    x(i+j,:) = [r*cos(j*ang) r*sin(j*ang) h/2];
end

    x(i+j+1,:) = cg;
    x(i+j+2,:) = cb;
    
no_of_points = no_of_points+2;
    
pt=zeros(no_of_points,3);
final_pt=zeros(no_of_points,3);

if sz_input(1)<1500
    inter = 1;
end

for count=1:inter:sz_input(1)

c_p=cos(phi(count));
c_t=cos(theta(count));
c_s=cos(si(count));
s_p=sin(phi(count));
s_t=sin(theta(count));
s_s=sin(si(count));
         
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
    
%     yy=plot3(final_pt(:,1),final_pt(:,2),final_pt(:,3),'b*');
%      plot3(x1(count),y1(count),z1(count),'k.');
     %CG
     cgpt=plot3(final_pt(i-1,1),final_pt(i-1,2),final_pt(i-1,3),'b*');
%    %CB
     cbpt=plot3(final_pt(i,1),final_pt(i,2),final_pt(i,3),'r*'); 
%     for i=1:no_of_points-1
%            aa(i) = line([final_pt(i,1) final_pt(i+1,1)], [final_pt(i,2) final_pt(i+1,2)], [final_pt(i,3) final_pt(i+1,3)]);
%     end
%     jj=line([final_pt(1,1) final_pt(i+1,1)], [final_pt(1,2) final_pt(i+1,2)], [final_pt(1,3) final_pt(i+1,3)]);


plt_pt=final_pt;

% ff = plot3(plt_pt(1:no_points,1),plt_pt(1:no_points,2),plt_pt(1:no_points,3),'k');
% gg = plot3(plt_pt(no_points+1:no_of_points,1),plt_pt(no_points+1:no_of_points,2),plt_pt(no_points+1:no_of_points,3),'k');
aa=zeros(no_points);
bb=zeros(no_points-1);
dd=zeros(no_points-1);

 for i=1:no_points
           aa(i)= line([plt_pt(i,1) plt_pt(i+no_points,1)], [plt_pt(i,2) plt_pt(i+no_points,2)], [plt_pt(i,3) plt_pt(i+no_points,3)],'Color','k');
 end   
 
 for i=1:no_points-1

           bb(i)= line([plt_pt(i,1) plt_pt(i+1,1)], [plt_pt(i,2) plt_pt(i+1,2)], [plt_pt(i,3) plt_pt(i+1,3)],'Color','r');
 end 
 cc = line([plt_pt(1,1) plt_pt(i+1,1)], [plt_pt(1,2) plt_pt(i+1,2)], [plt_pt(1,3) plt_pt(i+1,3)],'Color','k');
 
  for j=2:no_points

           dd(j-1) = line([plt_pt(i+j,1) plt_pt(i+j+1,1)], [plt_pt(i+j,2) plt_pt(i+j+1,2)], [plt_pt(i+j,3) plt_pt(i+j+1,3)],'Color','b');
 end 
 ee= line([plt_pt(i+2,1) plt_pt(i+j+1,1)], [plt_pt(i+2,2) plt_pt(i+j+1,2)], [plt_pt(i+2,3) plt_pt(i+j+1,3)],'Color','k');

    
%pause(t(sz_input(1))/(1000000000*sz_input(1)))
pause(speed)
    
if count<sz_input(1)
    delete(cc)
    delete(ee)
%     delete(ff)
%     delete(gg)
    delete(cgpt)
    delete(cbpt)
    
    for i=1:no_points
        delete(aa(i))
    end
    
    for i=1:no_points-1
        delete(bb(i))
        delete(dd(i))
    end
end
   
end


end
            

            
            
            