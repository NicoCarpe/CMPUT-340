% Sample script  that shows how to automate running problem solutions
close all;
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) Load an image using the imread command 

image = imread('peppers3.tif');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% b) Display original image in the first spot of a 2 x 3 a grid layout
%    Check the imshow and subplot commands.

subplot(2,3,1)
imshow(image)
title('Original Peppers Image')

pause()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% c) Display a gray scale version of the image in position 2 of the grid.
%    help rgb2gray

greyscale = rgb2gray(image);

subplot(2,3,2)
imshow(greyscale)
title('GreyScale Peppers Image')

pause()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% d) Generate a new figure and ask user to manually select a region of the
%    image. Display the subimage in position 3 of the grid.
%    Hint 1: getrect()
%    Hint 2: to use getrect, you should first install Image Processing Toolbox:
%         (a) Open the Add-On Manager in MATLAB via "Home > Add-Ons > Get Add-Ons" and install the Add-On Explorer if it is not already installed.
%         (b) Search "Image Processing Toolbox" and install it.
%         (c) Restart MATLAB after installing

% Get user input on a newly dislayed image

% Make grid the current figure

% Display selected region. Make sure to apply the cut
% over all 3 channels.

% You are NOT ALLOWED to use the imcrop function of Matlab.

% create new figure to select region on
f = figure; 
imshow(image)

% returns selected rectangle's position in array [xmin, ymin, width, height]
rect = getrect; 

% round position values of selected rectangle to integers to allow indexing
rect = round(rect); 

% crops image according to the selected rectangle's position values

% since we have a min value and width/length, we need to add min value to width/length to
% get the max value
cropped_image = image(rect(2):(rect(2) + rect(4)), rect(1):(rect(1) + rect(3)),:);

% close the figure used to select region
close(f) 

subplot(2,3,3)
imshow(cropped_image)
title('Selected region')

pause()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% e) Create a function J = luminance_change(I, option, value) such that:
%   * When given the option 'c', the contrast of image I's top-left and 
%     bottom-right quadrants will be modified by the given value.
%     Simple multiplication will achieve this.
%   * When given the option 'b', the brightness of image I's top-right and 
%     bottom-left quadrants will be modified by the given value.
%     Simple addition will achieve this.
%  
%   Showcase your function by filling positions 4 and 5 in the grid

% Contrast change

modified_image = luminance_change(image, 'c', 0.2);

subplot(2,3,4)
imshow(modified_image)
title('Modified Contrast')

pause()

% Brightness change

modified_image = luminance_change(image, 'b', 120);

subplot(2,3,5)
imshow(modified_image)
title('Modified Brightness')

pause()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% f) BONUS: Display a version of the image after it's been blurred using a
%    Gaussian filter. Hint: imgaussfilt()

gauss_blur_image = imgaussfilt(image,7);

subplot(2,3,6)
imshow(gauss_blur_image)
title('Gaussian Blur')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Functions

function modified_image = luminance_change(I, option, value)
    if option == 'c'
        modified_image = I*value;
    elseif option == 'b'
        modified_image = I+value;
    end
end
