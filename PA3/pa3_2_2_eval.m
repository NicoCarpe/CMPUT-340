%%% Question 2 Part a & b %%%

theta0 = [0; -1; 1];        % intitial joint angles
l = [0.8; 0.7];             % Link lengths
n = 10000;                  % maximum iterations
mode = 1;                   % Mode: 1 for Newton's method, 0 for Broyden's method

desired = [0; 0; -1];

% compute joint angles for new desired position 
theta = invKin3D(l, theta0, desired, n, mode); 

disp(['Target = ', mat2str(desired), ', Theta = ', mat2str(theta)]);

%%% Written Answers %%%

% 2a

%   As we move our desired position further from our initial guess, the initial guess becomes less 
%   accurate and thus does not lead to convergence for methods such as Newton's method. This is 
%   because Newton's method is sensitive to the initial guess and may fail to converge if the desired
%   position is too far from it.

% 2b

%   One solution to this could be splitting up the movement from the initial to the desired positions
%   into a series of points. This would avoid the issues of non-convergence that Newton's and Broyden's
%   method would have run into for points far apart, by applying the inverse kinematics algorithm at 
%   each step of the way.





%%% Question 2 part c %%%

start_point = [0; -1; 1];       % Current end effector position
end_point = [0; 1; -1];    % Target point in the opposite quadrant


num_segments = 10;              % Number of segments for the path between points

% Loop through each segment and incrementally move towards the target
for i = 1:num_segments

    % Calculate the intermediate target point
    fraction = i / num_segments;
    intermediate_target = start_point + fraction * (end_point - start_point);

    % Compute joint angles for the intermediate target
    theta = invKin3D(l, theta0, intermediate_target, n, mode);

    % Display the calculated joint angles
    disp(['Intermediate Step ', num2str(i), ': Target = ', mat2str(intermediate_target), ', Theta = ', mat2str(theta)]);

    % Update the initial guess for the next iteration
    theta0 = theta;
end


%%% Written Answers %%%

% 2c

%   When the target point is in the opposite quadrant of the initial position, we would have 
%   troubles using Newton's or Broyden's methods to calculate our end effector positions as 
%   they would most likely not converge. However, if we have our end effector moves through 
%   each intermediate target and update the initial guess for the joint angles, we will 
%   improve the chances of convergence in each of our steps and thus convergence to the end
%   effector positions of our desired point

