% Performs back-substitution recursively to solve Ux = b
function x = backSubst(U, y, k)
    [m,n] = size(U);
    
    % Base case of backSubst there will be no given k, so we define it here
    if ~exist('k')
        k=n;
    end
    
    x = y(k) / U(k, k);
    
    % Recursion step when k > 1
    if k > 1 

        % U[1:k, k] selects the kth column and then the zeros funtion 
        % fills the rows beneath the current row "k" with zeros
        u = [ U(1:k, k); zeros(n-k, 1)];
     
        % Works from bottom of the vector and solves backwards substituting
        % the values of x backwards since x_n is trivial to solve x can
        % eventually be solved if non-singular
        x = [pa1_2C(U, y-x*u, k-1); x];

    end
end