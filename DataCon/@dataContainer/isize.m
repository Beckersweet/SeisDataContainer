function d = isize(x,dim)
%ISIZE  Implicit dimensions of a data container
%
%   isize(x) returns the implicit dimensions 
%   of x in an N-elements row vectors D = [N1,n2,...,N].
%
%   isize(x,DIM) retuns the length of the implicit dimension specified 
%   by the scalar DIM.  Note that DIM must be within the dimensional range 
%   of x.
%
%   See also: dataContainer.size

%   Copyright 2009, Ewout van den Berg and Michael P. Friedlander
%   See the file COPYING.txt for full copyright information.
%   Use the command 'spot.gpl' to locate this file.

%   http://www.cs.ubc.ca/labs/scl/spot

% Setup variables
dims = x.imdims;

if nargin == 0
   error('Not enough input arguments');

elseif nargin > 2
   error('Too many input arguments');
   
elseif nargin > 1 && ~isempty('dim')
    if nargout > 1
       error('Unknown command option.');
    end
    if dim < 1 || dim > length(dims)
       error('Dimension argument must be within the dimensions of x');
    else
       d = dims(dim);
    end
    
else
   d = dims; 
end