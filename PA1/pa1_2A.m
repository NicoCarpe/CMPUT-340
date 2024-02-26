% Given matrix A and index k compute elimination matrix M_k and L_k
function [M_k, L_k] = elimMat(A, k)
    % Size of A as a vector [m,n]
    [m, n] = size(A);
    
    % Identity matrix of size A
    I = eye(m, n);
    
    % k-th column of the identity matrix
    e_k = I(:, k);
    
    % k-th column of matrix A
    a_k = A(:, k);
    
    % pivot is the kth element of the kth column of matrix A
    pivot = a_k(k);
    
    if pivot ~= 0
        % Find the values a_i below the pivot to calculate the multipliers m
        a_i = a_k(k+1:end);
        
        % Create the multipliers vector
        % Need to pad indexs 1 to k with 0s as we only have multipliers 
        % from k+1 to n

        multipliers = [zeros(k, 1); a_i / pivot];
        
        % Calculate the elimination matrix M_k
        M_k = I - multipliers * e_k';
        
        % Calculate the inverse of M_k to get L_k
        L_k = I + multipliers * e_k';

    else
        % 0 pivot, no elimination
        M_k = 0;
        L_k = 0;
        return;
    end
end
