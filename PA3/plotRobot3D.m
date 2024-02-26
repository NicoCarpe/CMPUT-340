function plotRobot3D(l,theta)
    %%This routine will plot the 3D robot for given angles theta. 
    %%Try plotRobot3D([0 0],[pi/6,pi/6,pi/6]) in the terminal below to check
    
    %% NOTE: Do not change the link lengths for this experiment. 
    % 3D robot 
    % link lengths 
    l1 = .8;
    l2 = .7;
    
    %% Follow the forward Kinematics given in the Introduction of the lab %%%%
      
      %%The first joint is fixed at [0 0 0] resting at a cylindrincal base([0 0 0] to [0 0 -1])
      %%Lets plot the base of the robot first
      [X1,Y1,Z1]=cylinder2P(0.2,100,[0,0,-1],[0 0 0]);%% You can look at the function below for the description of input arguments
      surf(X1,Y1,Z1,'FaceColor',[0.3010 0.7450 0.9330],'LineStyle','none')
      hold on
    
      %%Let's define the joint angles as q1, q2 and q3
      q1=theta(1);  q2=theta(2);  q3=theta(3);
      xp1=l1*cos(q1);
      xp2= xp1 + l2*cos(q1+q2);
      % Make 2D robot above 3D by projecting xp-z plane at different angles
      x1 = xp1*cos(q3);         % x coordinate of the second joint
      y1 = xp1*sin(q3);         % y coordinate of the second joint
      z1=l1*sin(q1);            % z coordinate of the second joint
      x2 = xp2*cos(q3);         % X coordinate of the end effector
      y2 = xp2*sin(q3);         % y coordinate of the end effector
      z2= z1 + l2*sin(q1+q2);   % z coordinate of the end effector
      
      %A sphere depicts a joint in our simulation so let's draw a sphere at our
      %first joint [0 0 0]
      getSphere(0.2,[0 0 0]);%Joint 1
      
      %%We have the coordinates of all the joints and the end effector
      %%above.Let's start plotting the remainig links and joints
      [X2,Y2,Z2]=cylinder2P(0.1,100,[0,0,0],[x1 y1 z1]); %link 1
      surf(X2,Y2,Z2,'FaceColor',[0.3010 0.7450 0.9330],'LineStyle','none');
      getSphere(0.15,[x1 y1 z1]);%Joint 2
      [X3,Y3,Z3]=cylinder2P(0.1,100,[x1 y1 z1],[x2 y2 z2]); %link 2
      surf(X3,Y3,Z3,'FaceColor',[0.3010 0.7450 0.9330],'LineStyle','none');
      getHemisphere(0.13,[x2 y2 z2],theta); % Vacuum funnel at end effector
      
    axis([-2 2,-2, 2,-2,2])
    view(3)
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    hold off;
    grid on;
    light;
    drawnow;
    
    end
    function [X, Y, Z] = cylinder2P(R, N,r1,r2)
     %%Input Arguments --- 
     %%%  R- radius of cylinder 
     %%%  N- number of dense points taken on the surface. Ex: 100
     %%%  r1- starting coordinate of cylinder (x1, y1, z1)
     %%%  r2- starting coordinate of cylinder (x2, y2, z2)
     %%%%%%~~~~~~~~~~~END~~~~~~~~~~~%%%%%%%
     %%% Output- Use this (X,Y,Z) to plot the surface of the cylinder between
     %%% the points r1 and r2
        theta = linspace(0,2*pi,N);
        m = length(R);                
                                      
        if m == 1                      
            R = [R; R];                
            m = 2;                    
        end
        X = zeros(m, N);             
        Y = zeros(m, N);
        Z = zeros(m, N);
        
        v=(r2-r1)/sqrt((r2-r1)*(r2-r1)');    
        R2=rand(1,3);             
        x2=v-R2/(R2*v');    
        x2=x2/sqrt(x2*x2');    
        x3=cross(v,x2);     
        x3=x3/sqrt(x3*x3');
        
        r1x=r1(1);r1y=r1(2);r1z=r1(3);
        r2x=r2(1);r2y=r2(2);r2z=r2(3);
        vx=v(1);vy=v(2);vz=v(3);
        x2x=x2(1);x2y=x2(2);x2z=x2(3);
        x3x=x3(1);x3y=x3(2);x3z=x3(3);
        
        time=linspace(0,1,m);
        for j = 1 : m
          t=time(j);
          X(j, :) = r1x+(r2x-r1x)*t+R(j)*cos(theta)*x2x+R(j)*sin(theta)*x3x; 
          Y(j, :) = r1y+(r2y-r1y)*t+R(j)*cos(theta)*x2y+R(j)*sin(theta)*x3y; 
          Z(j, :) = r1z+(r2z-r1z)*t+R(j)*cos(theta)*x2z+R(j)*sin(theta)*x3z;
        end
    end
    function getSphere(r,offset)
     %%Input Arguments --- 
     %%%  r- radius of sphere
     %%% offset - coordinates of the center of sphere(cx,cy,cz)
     %%%%%%~~~~~~~~~~~END~~~~~~~~~~~%%%%%%%
     %%% Output- Plots a sphere of radius 'r' at (cx,cy,cz)
    [Sx,Sy,Sz] =sphere;
    Sx=Sx*r + offset(1);
    Sy=Sy*r + offset(2);
    Sz=Sz*r + offset(3);
    hsurface = surf(Sx,Sy,Sz);
    hold on
    set(hsurface,'FaceColor',[0 0 1], ...
          'FaceAlpha',0.5,'FaceLighting','gouraud','EdgeColor','none')
    end
    function getHemisphere(r,offset,angle)
     %%Input Arguments --- 
     %%%  r- radius of sphere
     %%% offset - coordinates of the center of sphere(cx,cy,cz)
     %%% angle - joint angles of the robot
     %%%%%%~~~~~~~~~~~END~~~~~~~~~~~%%%%%%%
     %%% Output- Plots a hemisphere(funnel shaped) of radius 'r' at (cx,cy,cz)
    [x,y,z] = sphere;               
    x = x(:,6:16);                
    y = y(:,6:16);               
    z = z(:,6:16); 
    Sx=x*r + offset(1)+r*cos(angle(1)+angle(2))*cos(angle(3));
    Sy=y*r + offset(2)+r*cos(angle(1)+angle(2))*sin(angle(3));
    Sz=z*r + offset(3)+ r*sin(angle(1)+angle(2));
    axis=[offset(1)+r*cos(angle(1)+angle(2))*cos(angle(3)) offset(2)+r*cos(angle(1)+angle(2))*sin(angle(3)) offset(3) + r*sin(angle(1)+angle(2))];
    hold on
    hs = surf(Sx,Sy,Sz,'FaceColor',[0 0 0],'FaceAlpha',0.8,'FaceLighting','gouraud','EdgeColor','none');      %# Plot the surface
    direction = [0 1 0];            
    rotate(hs, direction,(angle(2)+angle(1))*(180/pi),axis) 
    
    direction = [0 0 1];            
    rotate(hs, direction,180+angle(3)*(180/pi),axis)  
     
    end