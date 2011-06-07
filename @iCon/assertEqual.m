function assertEqual(varargin)
%assertEqual Assert that inputs are equal
%   assertEqual(A, B) throws an exception if A and B are not equal.  A and B
%   must have the same class and sparsity to be considered equal.
%
%   assertEqual(A, B, MESSAGE) prepends the string MESSAGE to the assertion
%   message if A and B are not equal.
%
%   Examples
%   --------
%   % This call returns silently.
%   assertEqual([1 NaN 2], [1 NaN 2]);
%
%   % This call throws an error.
%   assertEqual({'A', 'B', 'C'}, {'A', 'foo', 'C'});
%
%   See also assertElementsAlmostEqual

varargin = cellfun(@(p) DataContainer.serial.stripicon(p),...
    varargin,'UniformOutput',false');
assertEqual(varargin{:});