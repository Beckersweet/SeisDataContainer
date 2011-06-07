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
for i = 1:length(x.perm)
    assert(isscalar(x.perm{i}),'Cannot unpermute with collapsed dimensions');
end

% Setup permutation order
operm = [x.perm{:}];

for i = 1:length(operm)
    for j = 1:length(operm)
        if operm(j) == i;
            toperm(i) = j;
        end
    end    
end

y = permute(x,toperm);