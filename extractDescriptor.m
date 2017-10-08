% extract descriptor
%
% Input:
%   keyPoints     - detected keypoints in a 2 x n matrix holding the key
%                   point coordinates
%   img           - the gray scale image
%   
% Output:
%   descr         - w x n matrix, stores for each keypoint a
%                   descriptor. m is the size of the image patch,
%                   represented as vector

function descr = extractDescriptor(corners, img)  
    % store descriptor in 81 x n array, 81 pixels and "n" is number of descriptors
    descr = zeros(81, length(corners));
    for i = 1:length(corners)-1
        row = corners(2*i - 1);
        col = corners(2*i);
        descr(:,i) = reshape(img(row-4:row+4, col-4:col+4), [81,1]);
    end
    return
end