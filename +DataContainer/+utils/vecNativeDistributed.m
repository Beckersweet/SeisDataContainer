function x = vecNativeDistributed(X)

assert(isdistributed(X),'input array must be a native MATLAB distributed array')

n = prod(size(X));
x = reshape(X,n,1);
