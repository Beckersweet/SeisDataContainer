function y = ldind(x,i)
%LDIND  Last-dimension indexing
%
%   ldind(x,i) will return the last-dimensional-slice of x

ind(1:length(size(x))-1) = {':'};
y = x(ind{:},i);