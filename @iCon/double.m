function y = double(x)
%DOUBLE     Returns the data contained in the data container
%
%   DOUBLE(X) returns the double precision value for X.
%   If X is already a double precision array, DOUBLE has
%   no effect.
%  
%   DOUBLE is called for the expressions in FOR, IF, and WHILE loops
%   if the expression isn't already double precision.  DOUBLE should
%   be overloaded for all objects where it makes sense to convert it
%   into a double precision value.

y = x.data;