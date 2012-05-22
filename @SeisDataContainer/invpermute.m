function y = invpermute(x)
%INVPERMUTE  Inverse-permutation of a data container
%
%   invpermute(X) permutes the data container back into the original
%   permutation as specified in the property, x.perm
%
%   Note: invpermute does not work with collapsed implicit dimensions (ie.
%   vec-ed data). Try using invvec on the data before doing invpermute
%
%   See also: iCon.permute, dataContainer.vec

% Check for collapsed dimensions
assert(all(cellfun(@isscalar,x.perm)),...
    'Cannot unpermute with collapsed dimensions');

% Setup permutation order
operm  = [x.perm{:}];
toperm = zeros(1,length(operm));

% Brute force search algorithm
for i = 1:length(operm)
    for j = 1:length(operm)
        if operm(j) == i;
            toperm(i) = j;
        end
    end    
end

y = permute(x,toperm);