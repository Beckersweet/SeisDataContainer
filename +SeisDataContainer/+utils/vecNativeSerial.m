function x = vecNativeSerial(X)

assert(~isdistributed(X),'input array must be a native MATLAB serial array')

n = prod(size(X));
x = reshape(X,n,1);

