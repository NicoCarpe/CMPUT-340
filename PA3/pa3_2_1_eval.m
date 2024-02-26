theta_a = [pi/2, pi/2, 0];   % intitial joint angles
theta_b = [pi/2, 0, 0];      % intitial joint angles

l = [0.8, 0.7];           % Link lengths

%%% a. Elbow is at pi/2 (orientation of the base joint does not matter) %%%
figure(1);
disp("a:")
show(l, theta_a)

%%% b. The whole arm is fully stretched upward in a straight line %%%
figure(2);
disp("b:")
show(l, theta_b)


function show(l, theta)
    % Plot the robot
    plotRobot3D(l, theta);

    % Calculate the Jacobian matrix 
    [~, J] = evalRobot3D(l, theta);

    % Display the Jacobian matrix
    disp('Jacobian matrix:');
    disp(J);

    % Calculate and display the condition number of the Jacobian matrix
    cond_num = cond(J);
    disp(['Condition number: ', num2str(cond_num)]);
end




%%% Written Answers %%%

% Jacobian matrix a:
%    -0.8000   -0.0000         0
%          0         0   -0.7000
%    -0.7000   -0.7000         0

% Condition number a: 2.4915


% Jacobian matrix b:
%    -1.5000   -0.7000         0
%          0         0    0.0000
%     0.0000    0.0000         0

% Condition number b: 2.056538760902071e+32


% From the results of these two sets of initial angles it is evident that
% b produces a singular jacobian matrix as its condition number is far
% larger than 1

% another rotational angle vector theta which also gives a singular
% Jacobian matrix is theta_c = [0, 0, 0], with resulting 

% Jacobian matrix c:
%          0         0         0
%          0         0    1.5000
%     1.5000    0.7000         0

% Condition number c: Inf


