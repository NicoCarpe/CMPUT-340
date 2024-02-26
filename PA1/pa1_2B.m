% Given matrix A find the LU factorization
function [L, U] = myLU(A)
    [m,n] = size(A);
    
    % Create temporary matrix, equivalent to A, to apply eliminations to
    % and one, equivalent to the identity matrix, to multiply the inverse of
    % the elimination matrixs to

    temp_matrix_1 = A;
    temp_matrix_2 = eye(m,n);
   
    
    % Apply elementary elimination matrices to find U    
    for k = 1:n-1
        [M_k, L_k] = pa1_2A(temp_matrix_1, k);
        
        % Apply the elimination matrix to temp_matrix_1 to find U
        temp_matrix_1 = M_k * temp_matrix_1;
        
        % Multiply temp_matrix_2 by L_k to calculate L (union of L_k)
        temp_matrix_2 = temp_matrix_2 * L_k;
    end
    
    % The after applying M_n-1 elementary eliminiation matices our
    % temporary matrix is now in the form of an upper triangular matrix (U)
    U = temp_matrix_1;
    
    % L is the product of all L_k matrices
    L = temp_matrix_2;
end
