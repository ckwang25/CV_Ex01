% show image with key points
%
% Input:
%   img        - n x m color image 
%   corner     - 2 x k matrix, holding keypoint coordinates of first image
%   fig        - figure id
function showImageWithCorners(img, corners, fig)
    figure(fig);
    imshow(img, []);
    
    hold on, plot(corners(2,:), corners(1,:), '+r');

end