function y = setImDims(x,varargin)
%SETIMDIMS  Setting implicit dimensions of data container
%
%   setImDims(x,{IMPLICIT_SIZE}) will return a *new* object with the same
%   content as x but with the new implicit size. To affect the changes to
%   your original x, you will need to do in-place assignment, ie.
%       x = setImDims(x,{2 3 4});
%
%   Also, your IMPLICIT_SIZE argument has to be a cell array, this gives
%   you freedom to specify which dimensions are actually collapsed in
%   relation to the explicit sizes, ie. {[2 3] 4} is collapsed version of
%   [6 4]
%
%   See also: isize

% Un-cell varargin
imdims = [varargin{:}];
assert(iscell(imdims),'Implicit dimensions must be stored in cell');
while(iscell(imdims))
    imdims = [imdims{:}];
end

% Check for number of elements
assert(prod(size(x)) == prod(imdims),...
    'Number of elements must be conserved');
y        = x;
y.imdims = [varargin{:}];