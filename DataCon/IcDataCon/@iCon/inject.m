function y = inject(x,data)
%INJECT  Inject data into empty data container
%
%   y = inject(x,DATA) returns a data container y containing all the
%   metadata stored in x but using the data DATA. x must be empty for this
%   to work.
%
%   See also: inject

% Check for empty
assert(isempty(x), 'X must be empty')
assert(numel(data) == prod(cell2mat(isize(x))),...
    'Number of elements must match')

% Copy and insert
y        = x;
y.data   = data;
y.exdims = size(data);
