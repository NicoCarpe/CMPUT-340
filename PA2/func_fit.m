function [coefficient_vector] = func_fit(X, Y, type, basis, parameters)
    % Check that the number of inputs and outputs are equal
    if ~isequal(size(X), size(Y))
        error('Input and output sizes must match');
    end
    
    % Determine the number of data points
    num_points = length(X);

    %%% interpolation %%%
    if (nargin == 4 && strcmp(type, 'interpolation'))
        parameters = num_points - 1; 

        if  strcmp(basis, 'poly')
            % Form the Vandermonde matrix (n-1 parameters)
            A = form_vandermonde(X, parameters, num_points);
            % solve the system of equations
            coefficient_vector = A \ Y;

        elseif strcmp(basis, 'trig')
            % Form the trigonometric basis matrix
            A = form_trig(X, parameters, num_points);
    
            % solve the system of equations
            coefficient_vector = A \ Y;

        else
            error('Invalid basis function')

        end

    %%% approximation %%%
    elseif strcmp(type, 'approximation')
        
        if  strcmpi(basis, 'poly')
            % Form the Vandermonde matrix
            A = form_vandermonde(X, parameters, num_points);
            
            % solve the system of equations
            coefficient_vector = A \ Y;

        elseif strcmp(basis, 'trig')
            % Form the trigonometric basis matrix
            A = form_trig(X, parameters, num_points);

            % solve the system of equations
            coefficient_vector = A \ Y;

        else
            error('Invalid basis function')

        end


    else
        error('Invalid number of input arguments for the type.');
    end  
end

function [A] = form_vandermonde(X, parameters, num_points)
     % Form the Vandermonde matrix (where P_k forms the vector space of dimension k + 1)
     A = zeros(num_points, parameters + 1);
    
     % fill matrix columnwise
     for i = 0:parameters
         A(:, i + 1) = X.^i;
     end
end

function [A] = form_trig(X, parameters, num_points)
    % Form the trigonometric basis matrix, since we need the cos and sin for the number of parameters + 1
    % and since sin(0) = 0, we have have 2*parameters + 1 (instead of 2*(parameters + 1) )
    A = zeros(num_points, 2 * parameters + 1);
    
    % set the first term to 1
    A(:, 1) = 1;
    
    for i = 1:parameters
        A(:, 2 * i) = cos(i * X);
        A(:, 2 * i + 1) = sin(i * X);
    end
end