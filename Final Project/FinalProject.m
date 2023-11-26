% Clean up.
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clearvars;
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 16;
fprintf('Beginning to run %s.m ...\n', mfilename);

%-----------------------------------------------------------------------------------------------------------------------------------
% Read in reference image with no cars (empty parking lot).
folder = pwd;
baseFileName = 'Parking Lot without Cars.jpg';
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
    % The file doesn't exist -- didn't find it there in that folder.
    % Alert user.
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
end
rgbEmptyImage = imread(fullFileName);
[rows, columns, numberOfColorChannels] = size(rgbEmptyImage);
% Display the test image full size.
subplot(1, 3, 1);
imshow(rgbEmptyImage, []);
axis('on', 'image');
caption = sprintf('Reference Image : "%s"', baseFileName);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
hp = impixelinfo(); % Set up status line to see values when you mouse over the image.

% Create a mask by thresholding the reference image.
grayEmptyImage = rgb2gray(rgbEmptyImage);
mask = grayEmptyImage < 100; % Adjust the threshold as needed.
mask = imfill(mask, 'holes');
mask = bwareaopen(mask, 2000); % Remove small noise regions.
subplot(1, 3, 2);
imshow(mask, []);
axis('on', 'image');
caption = 'Generated Mask';
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;

%-----------------------------------------------------------------------------------------------------------------------------------
% Read in test image (image with cars parked on the parking lot).
baseFileName = 'Parking Lot with Cars.jpg';
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
    % The file doesn't exist -- didn't find it there in that folder.
    % Alert user.
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
end
rgbTestImage = imread(fullFileName);
% Display the original image full size.
subplot(1, 3, 3);
imshow(rgbTestImage, []);
axis('on', 'image');
caption = sprintf('Test Image : "%s"', baseFileName);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
hp = impixelinfo(); % Set up status line to see values when you mouse over the image.

%-----------------------------------------------------------------------------------------------------------------------------------
% Find the cars using the generated mask.
diffImage = imabsdiff(rgbEmptyImage, rgbTestImage);
diffImage = rgb2gray(diffImage);
diffImage(~mask) = 0;

% Further processing steps to identify parked cars...
% (Your existing code for thresholding, filling holes, getting convex hull, etc.)

%-----------------------------------------------------------------------------------------------------------------------------------
% Measure the percentage of white pixels within each rectangular mask.
props = regionprops(mask, 'BoundingBox');

% Calculate other metrics and perform processing as needed using 'props' structure.

%-----------------------------------------------------------------------------------------------------------------------------------
% Display or perform any further analysis based on identified parking spaces.

fprintf('Done running %s.m ...\n', mfilename);
