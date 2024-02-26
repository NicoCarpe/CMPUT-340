%%% Question 3 %%%

% Example square matrix A
A = [-1, 3, -1
     3, 5, -1
     -1, -1, 2];

% Choose the max number of iterations to be used
max_k = 100;

% Use the built in matlab function to find eigenvalues and eigenvectors
[eigenvectors, eigenvalues_matrix] = eig(A);

eigenvalues = diag(eigenvalues_matrix);

% calculate the eigenvalues and eigenvectors using our iteration methods
[norm_pow_eigenvalue, norm_pow_eigenvector] = normalized_power_iteration(A, max_k);
[inv_eigenvalue, inv_eigenvector] = inverse_iteration(A, max_k);
[qr_eigenvalues, qr_eigenvectors] = QR_iteration(A, max_k);


disp('______________________________________________________')
disp('Question 1')
disp(' ')

%%% Question 1: %%%
% compare normalized power iteration with Matlab's default function in
% calculating the dominant eigenvalue and its corresponding eigenvector

% find the maximum absolute eigenvalue and its index
[dom_eigenvalue, dom_index] = max(abs(eigenvalues));

% use the eigenvalue's index to find the corresponding eigenvector
% note that the eigenvectors are stored columnwise 
dom_eigenvector = eigenvectors(:, dom_index);

% Display function results 
disp('Default Function')
disp('----------------')
disp(['dominant eigenvalue: ', num2str(dom_eigenvalue)])
disp('dominant eigenvector:')
disp(dom_eigenvector)

disp('Normalized Power Iteration')
disp('--------------------------')
disp(['dominant eigenvalue: ', num2str(norm_pow_eigenvalue)])
disp('dominant eigenvector:')
disp(norm_pow_eigenvector)


disp('______________________________________________________')
disp('Question 2')
disp(' ')

%%% Question 2: %%%
% compare inverse iteration with Matlab's default function in calculating 
% the smallesst eigenvalue and its corresponding eigenvector

% find the smallest absolute eigenvalue and its index
[min_eigenvalue, min_index] = min(abs(eigenvalues));

% use the eigenvalue's index to find the corresponding eigenvector
% note that the eigenvectors are stored columnwise 
min_eigenvector = eigenvectors(:, min_index);

% Display function results
disp('Default Function')
disp('----------------')
disp(['smallest eigenvalue: ', num2str(min_eigenvalue)])
disp('smallest eigenvector:')
disp(min_eigenvector)

disp('Inverse Iteration')
disp('-----------------')
disp(['smallest eigenvalue: ', num2str(inv_eigenvalue)])
disp('smallest eigenvector:')
disp(inv_eigenvector)


disp('______________________________________________________')
disp('Question 3')
disp(' ')

%%% Question 3: %%%
% compare qr iteration with Matlab's default function in calculating all
% the eigenvalues and their corresponding eigenvectors


% Display function results
disp('Default Function')
disp('----------------')
disp('eigenvalues: ')
disp(eigenvalues)
disp('eigenvectors: ')
disp(eigenvectors)

disp('QR Iteration')
disp('------------')
disp('eigenvalues: ')
disp(qr_eigenvalues)
disp('eigenvectors: ')
disp(qr_eigenvectors)

% note: qr iteration may not return eigenvalues and eigenvectors in the
%       same order as eig as it does not sort them in accending order

% note: signs may be different, but the eigenvectors are still valid as any
%       scalar multiple of an eigenvector is a valid eigenvector for the
%       eigenvalue


%%% Normalized Power Iteration %%
function [eigenvalue, eigenvector] = normalized_power_iteration(A, max_k)
    n = size(A, 1);
    % establish our arbitary nonzero vector
    x = rand(n, 1); 

    for k = 1:max_k
        y = A*x;                % x_k --> v_1 / norm(v_1, inf)
        x = y / norm(y, inf);   % y_k --> abs(lambda_1)
    end
    % y converges to the eigenvector corresponding to the dominant
    % eigenvalue of A
    
    % normalize the resulting vector (A scalar multiple of an eigenvector 
    % is still a valid eigenvector for the corresponding eigenvalue 
    eigenvector = y/norm(y);    

    % Use the Rayleigh quotient to calculate the dominant eigenvalue of A
    eigenvalue = (eigenvector' * A * eigenvector) / (eigenvector' * eigenvector); 
end



%%% Inverse Iteration %%
function [eigenvalue, eigenvector] = inverse_iteration(A, max_k)
    n = size(A, 1);
    % establish our arbitary nonzero vector
    x = rand(n, 1); 
    
    % will converge to the largest eigenvalue of A^-1, which in turn is
    % the smallest eigenvalue of A
    for k = 1:max_k
        y = A \ x;      
        x = y / norm(y, inf);   
    end
    
    % y converges to hte eigenvector corresponding to the dominant
    % eigenvalue of A^-1, and thus is convereges to the eignevector 
    % corresponding to the smallest eigenvalue of A

    % normalize the resulting vector (A scalar multiple of an eigenvector 
    % is still a valid eigenvector for the corresponding eigenvalue 
    eigenvector = y/norm(y);

    % Use the Rayleigh quotient to calculate the smallest eigenvalue of A
    eigenvalue = (eigenvector' * A * eigenvector) / (eigenvector' * eigenvector); 
end



%%% QR Iteration %%
function [eigenvalues, eigenvectors] = QR_iteration(A, max_k)
    n = size(A);
    % initialize the eigenvectors
    eigenvectors = eye(n);

    for k = 1:max_k
        [Q, R] = qr(A);          
        A = R * Q;
        
        % the eigenvectors can be found by taking the product of the
        % matrices Q 
        eigenvectors = eigenvectors * Q;
        
        % note: the columns of the product of Qs are the eigenvectors
    end
    
    % for comparison later we will want all our eigenvectors to be normalized
    for i = 1:n  
        eigenvectors(:, i) = eigenvectors(:, i) / norm(eigenvectors(:, i));
    end

    % A converges to schur form, therefor the eigenvalues can be 
    % approximated by the diagonal elements of the matrix A
    eigenvalues = diag(A);

    % note: since we are using a symmeytic matrix A, QR iteration preserves
    % the symmetry and the matrix we converge to is symmetric and thus
    % diagonal
end