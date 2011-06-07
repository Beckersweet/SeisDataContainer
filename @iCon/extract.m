function y = extract(x)
%EXTRACT    Extract metadata of data container
%
%   y = extract(x) returns an empty data container y containing all the 
%   vital metadata stored in x minus the actual data itself, as well as 
%   having its explicit dimensions set to zero.
%
%   See also: inject

y        = x;
y.data   = [];
y.exdims = [0 0];