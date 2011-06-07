function y = gather(x)
%GATHER Retrieve contents of a distributed data container to a single array
%   on the client 
%   X = GATHER(D) is a regular array formed from the contents
%   of the distributed data container D.

y = iCon(gather(double(x)));
y.imdims = x.imdims;