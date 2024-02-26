% Vectorize the following
% Note the use of the tic/toc calls to time execution
% Compare the time once you have vectorized it

%Original 
tic; 
for i = 1:1000
    t(i) = 2*i;
    y(i) = sin(t(i));
end
orig_time = toc;

%Vectorized
tic; 
i = 1:1000;

t(i) = i*2; 
y(i) = sin(t(i));
vect_time = toc;

disp(orig_time)
disp(vect_time)

diff = orig_time - vect_time;

fprintf('The vectorized code is %f seconds faster than the origional code.\n',diff);

clear;

