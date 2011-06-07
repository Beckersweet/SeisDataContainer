function y = conj(x)
%CONJ  Elementwise conjugate of data container
%
%   conj(x) is the elementwise conjugate of the data container x.
%
%   See also iCon.real

y      = x;
y.data = conj(double(x));
