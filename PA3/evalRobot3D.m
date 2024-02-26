function [pos,J] = evalRobot3D(l,theta)
    %Calculating the positon of the end effector
    x=(l(1)*cos(theta(1)) + l(2)*cos(theta(1)+theta(2)))*cos(theta(3));
    y=(l(1)*cos(theta(1)) + l(2)*cos(theta(1)+theta(2)))*sin(theta(3));
    z=l(1)*sin(theta(1)) + l(2)*sin(theta(1)+theta(2));

    pos=[x y z];

    xp2=l(1)*cos(theta(1)) + l(2)*cos(theta(1)+theta(2));

    %Calculating the Jacobian of the matrix
    dq1 = -(l(1)*sin(theta(1)) + l(2)*sin(theta(1)+theta(2))) ;
    dq2 = -l(2)*sin(theta(1)+theta(2));

    J= [dq1*cos(theta(3)) dq2*cos(theta(3)) -xp2*sin(theta(3))
        dq1*sin(theta(3)) dq2*sin(theta(3)) xp2*cos(theta(3))
        xp2 l(2)*cos(theta(1)+theta(2)) 0];
end