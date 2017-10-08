% show feature matches between two images
%
% Input:
%   img1        - n x m color image 
%   corner1     - 2 x k matrix, holding keypoint coordinates of first image
%   img2        - n x m color image 
%   corner2     - 2 x k matrix, holding keypoint coordinates of second image
%   fig         - figure id

function showFeatureMatches(img1, img2, matches, corners1, corners2, fig)
    [sx, sy, sz] = size(img2);
    img = [img2, img1];
    
    if length(corners1) <= length(corners2)
        seed = corners1;
        pool = corners2;
    else
        seed = corners2;
        pool = corners1;
    end
    
    % read the matched corners coordinates
    corner1 = seed(:, [matches(1,:)]);
    corner2 = pool(:, [matches(2,:)]);
    % translate corner2 coordinates with dx units on to the img2
    corner2 = corner2 + repmat([0, sy]', [1, size(corner2, 2)]);
    
    figure(fig), imshow(img, []);    
    hold on, plot(corner1(2,:), corner1(1,:), '+r');
    hold on, plot(corner2(2,:), corner2(1,:), '+r');  
    hold on, plot([corner1(2,:); corner2(2,:)], [corner1(1,:); corner2(1,:)], 'b');
end