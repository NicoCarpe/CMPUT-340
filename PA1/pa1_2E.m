test_As = [

[1 2 2; 4 4 2 ; 4 6 4];
[1 2 3; 3 2 4 ; 1 3 2]

];

test_bs = [

[3; 6; 10];
[1; 1; 3]

];

test_xs = [
    
[-1; 3; -1];
[-1; 2; 2]

];



% Find the number of columns in the matrix
sz = size(test_As, 2);

for test = 1:(size(test_As, 1) / sz)
    fprintf("TEST %d:\n\n", test)
    
    % Display A and b for the current test
    disp("A:")
    disp(test_As(1 + (test - 1) * sz: test * sz, :, :))
    disp("b:")
    disp(test_bs(1 + (test - 1) * sz: test * sz, :))
    
    % Compute the LU decomposition of the matrix A
    [L, U] = pa1_2B(test_As(1 + (test - 1) * sz: test * sz, :, :));
    
    % Check that matrix was not singular
    if ~isequal(L * U, 0)

        % Use forward substitution to apply the elementary elimination matrices to the b vector        
        y = fwdSubst(L, test_bs(1 + (test - 1) * sz: test * sz, :));
        
        
        % Using backward substitution, we can solve for x by starting with the
        % trivial x_m = u(m, n) and substituting it back into the equation above and
        % repeating until all values of x can be calculated
        x = pa1_2C(U, y);
    end
    

    % If the LU factorization is correct, LU = A
    if isequal(L * U, test_As(1 + (test - 1) * sz: test * sz, :, :))
        fprintf('The LU factorization is correct!\n\n')
        disp("L:")
        disp(L)
        disp("U:")
        disp(U)
    
    % Catch if the matrix is singular
    elseif isequal(L * U, 0)
        fprintf('The LU factorization failed, matrix A is singular!\n\n')
    else
        fprintf('LU Check failed!\n\n')
    end

       
    % Check if forward and back substitutions return correct values for x
    if isequal(x, test_xs(1 + (test - 1) * sz: test * sz, :))
        fprintf('The x value was calculated correctly!\n\n')
        disp("x:")
        disp(x)

    % Catch if the matrix is singular
    elseif isequal(L * U, 0)
        fprintf('Matrix A is singular, x cannot be calculated!\n\n')
    else
        fprintf('x Check failed!\n\n')
    end
end
