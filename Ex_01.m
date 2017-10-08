% Exercise 1
close all;

IMG_NAME1 = 'testImages/I01.jpg';
IMG_NAME2 = 'testImages/I02.jpg';

% read in image
img1 = im2double(imread(IMG_NAME1));
img2 = im2double(imread(IMG_NAME2));

img1 = imresize(img1, 1);
img2 = imresize(img2, 1);

% convert to gray image
imgBW1 = rgb2gray(img1);
imgBW2 = rgb2gray(img2);

% extract Harris corners
percent = 0.01;  % define the threshold to be the minimum value of the top 1% Harris response
[corners1, H1] = extractHarrisCorner(imgBW1, percent);
[corners2, H2] = extractHarrisCorner(imgBW2, percent);

% show images with Harris corners
showImageWithCorners(img1, corners1, 10);
showImageWithCorners(img2, corners2, 11);

% extract descriptors
descr1 = extractDescriptor(corners1, imgBW1);
descr2 = extractDescriptor(corners2, imgBW2);
    
% match the descriptors
th = 0.01; %%% empirical value? 
           %%% --> this value highly depends on the similarity of two images
matches = matchDescriptors(descr1, descr2, th);

% plot matched pair on both images
showFeatureMatches(img1, img2, matches, corners1, corners2, 20);
