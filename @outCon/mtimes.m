function y = mtimes(A,B,swapflag)
%*  Matrix multiplication
%   X*Y is the matrix product of X and Y.  Any scalar (a 1-by-1 matrix)
%   may multiply anything.  Otherwise, the number of columns of X must
%   equal the number of rows of Y.

% unswap
if nargin == 3 && strcmp(swapflag,'swap')
    tmp = B;
    B   = A;
    A   = tmp;
    clear('tmp');
end