function y = permute(x,varargin)
%PERMUTE    Permutation for data container
%
%   permute(X,N1,N2,...,N) permutes the data container according to the
%   order of permutation [N1,N2,...,N]
%
%   See also: invpermute

% Setup variables
perm = [varargin{:}];

% Check for permutation dimensions
assert(length(perm) == length(x.perm),'Permutation dimensions mismatch')

% Setup future variables
% Find final distributed dimension and setup global size at the same
% time
ngsize = zeros(2,ndims(x));
toperm = zeros(1,ndims(x));
nisize = [];
for  i = 1:length(perm) % Find new dimension of distribution
    % Rearrange explicit size
    ngsize(:,i)  = x.exsize(:,perm(i));
    
    % Rearrange permutation
    toperm(i)  = x.perm(perm(i));
    
    % Rearrange implicit size
    nisize = [ nisize x.header.size(ngsize(1,i):ngsize(2,i)) ];
end

% Recalibrate explicit size
ngsize(:,1) = ngsize(:,1) - ngsize(1,1) + 1;
for i = 2:length(ngsize)
    ngsize(:,i) = ngsize(:,i) - ngsize(1,i) + ngsize(2,i-1) + 1;
end

y = iCon(permute(x.data,perm));

% Set variables
y.header      = SeisDataContainer.permuteHeaderStruct(x.header,perm);
y.perm        = toperm;
y.exsize      = ngsize;
y.header.size = nisize;