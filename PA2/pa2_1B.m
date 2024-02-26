format long

% read in the file contents
fileID = fopen('pa2q1datasets.txt');

data1 = [];
data2 = [];

count = 1;
while ~feof(fileID) % check for end of file
    line = fgetl(fileID); 
    
    % ignore the empty lines
    if size(line,1) == 0
        continue
    end
    
    % isolates the values and splits by whitespace, then removes empty entries
    line = rmmissing(split(line(7:end-1)));
    
    %convert to a floating point number from string
    line = str2double(line);    
    
    % store each data set seperately  
    if count <= 2
        data1 = [data1; line.'];
    else
        data2 = [data2; line.'];
    end
    
    count = count + 1;
    
end

fclose(fileID);

x1 = data1(1,:);
y1 = data1(2,:);

x2 = data2(1,:);
y2 = data2(2,:);

% calculate the coefficients for each of the functions to be plotted
c1_a = pa2_1A(x1, y1, "approximate", "trig", 4);
c1_i = pa2_1A(x1, y1, "interpolate", "trig", 0);
c2_a = pa2_1A(x2, y2, "approximate", "poly", 4);
c2_i = pa2_1A(x2, y2, "interpolate", "poly", 0);

c1_a = c1_a(end:-1:1)';
c1_i = c1_i(end:-1:1)';
c2_a = c2_a(end:-1:1)';
c2_i = c2_i(end:-1:1)';

% find the corresponding y values 
y1_a = @(x) c1_a(1)+c1_a(2)*cos(2*x)+c1_a(3)*cos(3*x);
y1_i = @(x) c1_i(1)+c1_i(2)*cos(2*x)+c1_i(3)*cos(3*x)+c1_i(4)*cos(4*x)+c1_i(5)*cos(5*x)+c1_i(6)*sin(6*x)+c1_i(7)*sin(7*x)+c1_i(8)*sin(8*x)+c1_i(9)*sin(9*x)+c1_i(10)*cos(10*x);


xx2=linspace(min(-6),max(6));
yy2_a = polyval(c2_a, xx2);
disp(yy2_a)
yy2_i = polyval(c2_i, xx2);
disp(yy2_a)



% plot dataset 1 and its functions 
subplot(1,2,1)


scatter(x1, y1)
hold on 
xlim([-8,8])
ylim([-1,1])

hold off
title('Dataset 1');


% plot dataset 2 and its functions 
subplot(1,2,2)

scatter(x2, y2)

hold on
xlim([-6,6])
ylim([-5,40])
plot(xx2, yy2_a, 'r', xx2, yy2_i, 'b')
hold off
title('Dataset 2');
