% match descriptors
%
% Input:
%   descr1        - k x n descriptor of first image
%   descr2        - k x m descriptor of second image
%   thresh        - scalar value to threshold the matches
%   
% Output:
%   matches       - 2 x w matrix storing the indices of the matching
%                   descriptors
function matches = matchDescriptors(descr1, descr2, thresh)
    % start with descriptor seeds (the fewer one) and match them with another
    % descriptor pool
    if length(descr1) <= length(descr2)
        descrSeed = descr1;
        descrPool = descr2;
    else
        descrSeed = descr2;
        descrPool = descr1;
    end
    
    matches = [];
    for i = 1:length(descrSeed)
        threshold = thresh;
        pair = zeros(2,1);
        for j = 1:length(descrPool)
            SSD = sum((descrSeed(:,i) - descrPool(:,j)).^2);
            % if SSD value lower than threshold and the corresponding
            % descriptor is not yet matched --> matched!
            if SSD < threshold 
                threshold = SSD;
                pair = [i; j];
            end
        end
        
        % append the matched pair into matches array
        if pair == zeros(2,1)
            continue
        else
            matches = cat(2, matches, pair);
        end
    end
end