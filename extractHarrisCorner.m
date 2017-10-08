% extract harris corner
%
% Input:
%   img           - n x m gray scale image
%   thresh        - scalar value to threshold corner strength
%   
% Output:
%   corners       - 2 x k matrix storing the keypoint coordinates
%   H             - n x m gray scale image storing the corner strength

function [corners, H] = extractHarrisCorner(img, percent)
    % blur image to get rid of noise
    kernel = ones(3); 
    Filter = fspecial('gaussian', size(kernel));
    blur = imfilter(img, Filter, 'replicate');
    
    % create image gradient and parameters for the Harris matrix
    [gx, gy] = imgradientxy(blur);
    Ix_2 = gx .* gx;
    Iy_2 = gy .* gy;
    IxIy = gx .* gy;
    
    % basic image information
    [rSize, cSize, zSize] = size(img);
    H = zeros(rSize, cSize);
    
    % convolution over a 3x3 moving window of the gradient parameter
    ssqrt_Ix = conv2(Ix_2, kernel, 'same');
    ssqrt_Iy = conv2(Iy_2, kernel, 'same');
    sIxIy = conv2(IxIy, kernel, 'same');
    
    % calculate Harris response
    for i = 1:rSize
        for j = 1:cSize
            E = zeros(2);
            E(1,1) = ssqrt_Ix(i, j);
            E(1,2) = sIxIy(i, j);
            E(2,1) = sIxIy(i, j);
            E(2,2) = ssqrt_Iy(i, j);
            evalue = eig(E);
            det_H = evalue(1) * evalue(2);
            trace_H = evalue(1) + evalue(2);
            K = det_H/trace_H;
            H(i,j) = K;
        end
    end
    
    % define the threshold to be the top ?% of the H values defined by the users. 
    % then, find pixel coordinate with Harris response larger than threshold
    nOfPixels = rSize*cSize;
    [val, ~] = sort(reshape(H, [nOfPixels, 1]),'descend');
    thresh = val(round(nOfPixels * percent));
    [cRow, cCol] = find(H > thresh);
    
    %{
    % without non-maximum suppression
    corners = [cRow'; cCol'];
    return
    %}
    
    % Non-Maximum-Suppression
    new_cRow = [];
    new_cCol = [];
    for i = 1:length(cRow)
        % the pixel will be discarded if it is too close to the image
        % boundary, othersie the patch can't be extracted
        if cRow(i) > 4 && cRow(i) < rSize-4 && cCol(i) > 4 && cCol(i) < cSize - 4 
            neighbor = img(cRow(i)-1:cRow(i)+1, cCol(i)-1:cCol(i)+1);
            % if the center pixel intensity is larger than the surrounding
            % --> store the pixel coordinate
            cetner_pixel = img(cRow(i), cCol(i));
            if sum(sum(neighbor < cetner_pixel)) == 0
                new_cRow(end+1) = cRow(i);
                new_cCol(end+1) = cCol(i);
            end
        end
    end
    corners = [new_cRow; new_cCol];
    return
    
end