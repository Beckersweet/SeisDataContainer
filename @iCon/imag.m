function y = imag(x)
%IMAG  Complex imaginary part.
%
%   imag(A) returns a new operator comprised of imaginary part of A.
%
%   See also real

y = x;
y.data = imag(double(x));