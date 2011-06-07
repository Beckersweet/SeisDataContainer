function y = eq(A,B)
%==  Equal.
%   A == B does element by element comparisons between A and B
%   and returns a matrix of the same size with elements set to logical 1
%   where the relation is true and elements set to logical 0 where it is
%   not.  A and B must have the same dimensions unless one is a
%   scalar. A scalar can be compared with any size array.
%
%   Note: Returns a Matlab logical array

y = eq( double(A), double(B) );