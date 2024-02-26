l = [1; 1];          % link lengths 

h = 1;              % step size

n = 10000;          % maximum iterations

mode = 1;           % Mode: 0 for Newton's method, 1 for Broyden's method

theta = rand(2,1);  % Choose random starting angles


% evaluate effect of mode and plot
tstart = tic; 

clf;
plotRobot2D(l, theta);
hold off;

while(1)
    % Get desired position from user
    desired = ginput(1)'; 
    
    clf;
    plot(desired(1), desired(2), '*');
    hold on;
    plotRobot2D(l, theta, ':'); 
    
    % hypotenus of desired arm and arm restricted by radius 
    hypo_rad = l(1) + l(2); 
    hypo_desire = sqrt(desired(1)^2 + desired(2)^2);
    
    % if the selected point is beyond the reach of the arm restrict it
    if hypo_desire > hypo_rad 
         desired = desired * (hypo_rad/hypo_desire);
    end


    % Solve and display the position
    
    % measure the time of computation
    tstart_1 = tic; 
    theta = invKin2D(l, theta, desired, n, mode); 
    tend_1 = toc(tstart_1);
    
    plotRobot2D(l, theta);
    hold off;
    
    %display the time of compuation for the method
    disp(tend_1)
end




%%% Written Responses %%%


% 2a. Are the results close enough to be useful?

%   The results from the Jacobian approximation are close to those of the analytical solution
%   when an appropriate step size 'h' is chosen (sufficiently small); if 'h' is too large the 
%   approximation may not be accurate, when 'h' is too small, however, there may be numerical 
%   instability.

% 2b. Why would you use this finite-difference approximation instead of the analytic derivative?

%   It may be useful to use this finite-difference approximation instead of 
%   the analytic derivative when calculating the gradient of each function 
%   becomes too costly or is unknown. The trade-off between error and computing time may be
%   worthwile in these situations.

% 4a)

%   Newton's method converged slightly faster but seemed to need a better initial guess to ensure 
%   that convergence. On the other hand Broyden's method seemed to be less sensitive to initial
%   guesses, but on the whole converged more slowly than the Newton's method. However it is important 
%   to note that since the Broyden's method updates the Jacobian far less frequently, it can be 
%   expected to perform better than Newton's method in situations where the Jacobian is more 
%   expensive to compute.



