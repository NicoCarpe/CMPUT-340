function theta = invKin2D(l, theta0, pos, n, mode)
    % returns the rotation angles in a 2x1 vector theta 
    % that put the end-effector at pos

    % terminate when a constraint is satisfied (use a threshold on the 
    % norm of the residual) or when the n iterations have occurred.
    
    % mode = 0 --> Newton's Method
    % mode = 1 --> Broyden's Method
    
    % Note: Newton's and, by extension, Broyden's methods may not coverge
    %       if not started close enough to the solution

    threshold = 0.001;
    
    % initialize the Jacobian matrix
    [current_pos, J] = evalRobot2D(l, theta0);

    % initialize set of angles theta with an intitial guess
    theta = theta0;


    %%% Newton's Method %%%
    if mode == 1

        % terminate when constraint is satisfied () or after n iterations 
        for  i = 1:n

            f = current_pos - pos;
            
            % terminate when constraint is satisfied or after n iterations 
            res_norm = norm(f, "inf");  
            
            if res_norm < threshold 
                break
            end

            % Newton Step
            s = -J \ f;                     

            % Update 
            theta = theta + s;              
            
            % recalculate the Jacobian matrix
            [current_pos , J] = evalRobot2D(l, theta);

        end
    end
    

    %%% Broyden's Method %%%
    if mode == 0

        % terminate when constraint is satisfied or after n iterations 
        for  i = 1:n
            
            f = current_pos - pos;
           
            % constraint stopping condition using the norm of the residuals
            res_norm = norm(f, "inf"); 

            if res_norm < threshold
                break
            end
            
            % calculate the step
            s = -J \ f;  
            
            % update theta with step
            theta = theta + s; 
            
            % recalculate the updated position
            current_pos(1) = l(1) * cos(theta(1)) + l(2) * cos(sum(theta));
            current_pos(2) = l(1) * sin(theta(1)) + l(2) * sin(sum(theta));             
            
            % Update jacobian approximation
            f_new = current_pos - pos;
            y = f_new - f;

            J = J + ((y - J * s) * s') / (s' * s);     % Recompute Jacobian
        end
    end
end