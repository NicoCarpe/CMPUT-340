function [coefficient_vector] = func_fit(X,Y,type,basis,parameters)
    % "X" and "Y" are input and output vectors of dimension n
    % "type" is a string that can be either approximate or interpolate
    % "basis" is a string specifying the basis function to use
    % "parameters" is a scalar specifying the number of parameters to approximate when approximate is selected.
    
    if type == "approximate"


        if basis == "poly"
           
            m = size(X,2); % find the length of the array of data
            n = parameters;
            A = ones(m,n);
            b = Y.';
            
            % a_0^x^0 + a_1*x^1 + ... + a_m*x^m for each element of x x_i
            % create the vandermonde matrix
            for i = 1:m
                for j = 1:n

                    A(i,j) = X(i)^(j-1);
                end
            end
            
            % inverting X.'X can lead to unacceptable rounding errors,
            % the backslash operator uses QR decomposition with pivoting,
            % which is a stable algorithm numerically
            
            % solve for the coefficients (x = (A.'A)^-1 A.'b)
            % (A.'A)^-1 A.' is the same as the pseudoinverse

            coefficient_vector = (A.'*A)\(A.'*b);
        end



        if basis == "trig"

            m = size(X,2);
            n = parameters;
            A = zeros(m,n);
            b = Y.';
                
            odd = mod(n, 2);
                
            if odd == 1
                k = (n - 1)/2;
            else
                k = floor((n - 1)/2);
            end
            
            % a_0 + (a_1*cos(x) + b_1*sin(x)) ... + (a_n-1*cos(((n-1)/2)x) + b_n-1*sin(((n-1)/2)x)) + a_n*cos(nx) for each element of x x_i
            for i = 1:m
                % first row is just constants 
                A(i,1) = 1;
               
                for j = 1:k
                    A(i,j+1) = cos(j*X(i));
                    A(i,j+k+1) = sin(j*X(i));        
                end
                
                % if the number of parameters is even, add an additional
                % cosine is needed to make up for the floor operation
                if odd == 0
                    A(i,n) = cos(n*X(i));
                end
            end
            
            coefficient_vector = (A.'*A)\(A.' * b);
            disp(coefficient_vector)
        end
    end
    


    if type == "interpolate"


        if basis == "poly"

            n = size(X,2);
            A = ones(n,n);
            b = Y.';
            
            % a_0^x^0 + a_1*x^1 + ... + a_n*x^n for each point x_i
            % create the vandermonde matrix
            for i = 1:n
                for j = 1:n
                    A(i,j) = X(i)^(j-1);
                end
            end
            
            % we can calculate the inverse directly as A is an nxn matrix
            coefficient_vector = A\b;
        end



        if basis == "trig"
            n = size(X,2);
            A = ones(n,n);
            b = Y.';
               
            odd = mod(n, 2);
                
            if odd
                k = (n - 1)/2;
            else
                k = floor((n - 1)/2);
            end
            
            % a_0 + (a_1*cos(x) + b_1*sin(x)) ... + (a_n-1*cos(((n-1)/2)x) + b_n-1*sin(((n-1)/2)x)) + a_n*cos(nx) for each element of x x_i
            for i = 1:n
                % first row is just constants 
                A(i,1) = 1;
        
                for j = 1:k
                    A(i,j+1) = cos(j*X(i));
                    A(i,j+k+1) = sin(j*X(i));
                end
                
                % if the number of points is even, add an additional
                % cosine to make up for the floor operation
                if odd == 0
                    A(i,n) = cos(n*X(i));
                end

            end

            coefficient_vector = A\b;
        end
    end
end


  
            %Y_new = zeros(size(Y));
            
            % apply the multipliers and polynomial basis to each value of y  
            % iteratively go through each y value y_i
            %for i = 1:size(Y)
            %    Y_new(i) = dot(x, A(i,:));
            %end

