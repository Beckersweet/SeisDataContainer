function varargout = size(x,dim)
%size  Dimensions of a data container
%
%   D = size(x), for a data container x, returns the dimensions of x in an
%   N-elements row vectors D = [N1,n2,...,N].
%
%   M = size(x,DIM) retuns the length of the dimension specified by
%   the scalar DIM.  Note that DIM must be within the dimensional range of 
%   x.

%   Copyright 2009, Ewout van den Berg and Michael P. Friedlander
%   See the file COPYING.txt for full copyright information.
%   Use the command 'spot.gpl' to locate this file.

%   http://www.cs.ubc.ca/labs/scl/spot

% Setup variables
dims = x.exdims;

if nargin == 0
   error('Not enough input arguments');

elseif nargin > 2
   error('Too many input arguments');
   
elseif nargin > 1 && ~isempty('dim')
    if nargout > 1
       error('Unknown command option.');
    end
    if dim < 1 
        error('Dimension argument must be within the dimensions of x');
    elseif dim > length(dims)
        varargout{1} = 1;
    else
        varargout = num2cell(dims(dim));
    end
    
else
    if nargout <= 1
        varargout{1} = dims;
    else
        varargout = num2cell(dims);
    end
end