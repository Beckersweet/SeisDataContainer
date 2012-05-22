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
assert(all(arrayfun(@isscalar,x.perm)),...
    'Cannot unpermute with collapsed dimensions');

% Setup permutation order
toperm = zeros(1,length(x.perm));

% Brute force search for original permutation
for i = 1:length(x.perm)
    for j = 1:length(x.perm)
        if x.perm(j) == i;
            toperm(i) = j;
        end
    end    
end

y = permute(x,toperm);