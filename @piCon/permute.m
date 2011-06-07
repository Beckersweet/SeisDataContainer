function y = permute(x,varargin)
%PERMUTE    Permutation for data container
%
%   permute(X,N1,N2,...,N) permutes the data container according to the
%   order of permutation [N1,N2,...,N]
%
%   If X is distributed, the distribution dimension will always be
%   conserved relatively. ie. no redistribution or communication of
%   elements happen under the hood.
%
%   See also: invpermute

% Setup variables
perm = [varargin{:}];

% Check for x and distributed and permutation dimensions
assert(isa(x,'piCon'),'X must be a parallel data container')
assert(length(perm) == length(x.perm),'Permutation dimensions mismatch')

% Setup future variables
% Find final distributed dimension and setup global size at the same time
fdim   = 0; % New explicit distributed dimension
fidim  = 0; % New implicit distribtued dimension
gsize  = x.exdims; % Global size
gisize = isize(x); % Global implicit size
operm  = x.perm; % Original permutation
for  i = 1:length(perm) % Find new dimension of distribution
    if perm(i) == x.excoddims
        fdim   = i;
    end
    if perm(i) == x.imcoddims
        fidim   = i;
    end
    tgsize(i)  = gsize(perm(i));
    tgisize(i) = gisize(perm(i));
    toperm(i)  = operm(perm(i));
end

% Setup variables
data = x.data;

spmd
    % Setup local parts and Permute and re-codistribute
    data = getLocalPart(data);
    part = codistributed.zeros(1,numlabs);
    data = permute(data,perm);
    part(labindex) = size(data,fdim);
    cod  = codistributor1d(fdim,part,tgsize);
    data = codistributed.build(data,cod,'noCommunication');
end % spmd

% Set variables
y           = piCon(data);
y.imcoddims = fidim;
y.perm      = toperm;
y.imdims    = tgisize;