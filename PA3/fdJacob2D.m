function J = fdJacob2D(l, theta, h)
    % uses central differences to compute the Jacobian using h

     % Initialize the Jacobian matrix
     J = zeros(2, 2);

    % calculate column wise instead of row wise, i.e. for each e_i*h 
    % [h, 0;
    %  0, h]
    
    % When we call evalRobot2D in this way the return is the positions
    % based off of the parameters and set functions
    
    J(:, 1) = ( evalRobot2D(l, theta + [h; 0]) - evalRobot2D(l, theta - [h; 0]) ) / (2 * h);
     
    J(:, 2) = ( evalRobot2D(l, theta + [0; h]) - evalRobot2D(l, theta - [0; h]) ) / (2 * h);  
end
