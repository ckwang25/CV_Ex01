IMG_NAME1 = 'testImages/I01.jpg';
IMG_NAME2 = 'testImages/I02.jpg';

% read in image
%img1 = im2double(imread(IMG_NAME1));
%img1 = imresize(img1, 1);
img2 = im2double(imread(IMG_NAME2));
img2 = imresize(img2, 1);

% show image
%image(img1) ;
image(img2) ;

% convert to single precision and gray scale image
%Ia = single(rgb2gray(img1)) ;
Ib = single(rgb2gray(img2)) ;

% calculate and plot descriptors
%[fa, da] = sift(Ia);
[fb, db] = sift(Ib);

% matching
%[matches, scores] = vl_ubcmatch(da, db) ;

