function [pos, J] = evalRobot2D(l, theta)
    % returns the position "pos" (2x1 vector) of the end-effector 

    % returns the Jacobian of of pos "J" given the rotation angles "theta"
    % and the fixed link lengths "l" 
     
    pos = [0; 0];

    % find the effector position of each link and sum them to get the end 
    % effector position
   
    pos(1) = l(1) * cos(theta(1)) + l(2) * cos(sum(theta));
    pos(2) = l(1) * sin(theta(1)) + l(2) * sin(sum(theta));

    %%% implement J analytically

    % to then find the Jacobian analytically we just find the matrix:
    % [∂f1/θ1, ∂f1/θ2, ..., ∂f1/θn ; ∂f2/θ1, ∂f2/θ2, ..., ∂f2/θn; ...; ∂fn/θ1, ∂fn/θ2, ..., ∂fn/θn] 
    % where f1 f2 ... fn are our nonlinear equations

    % since our problem only is a 2D planar manipulator with two links and two rotational degrees
    % this is the analytical Jacobian calculation in respect to theta 
    J = zeros(2, 2);

    J(1, 1) = -l(1) * sin(theta(1)) - l(2) * sin(sum(theta));
    J(1, 2) = -l(2) * sin(sum(theta));
    J(2, 1) = l(1) * cos(theta(1)) + l(2) * cos(sum(theta));
    J(2, 2) = l(2) * cos(sum(theta));

end