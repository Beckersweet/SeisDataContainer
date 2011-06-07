function assertFalse(varargin)
%assertFalse Assert that input condition is false
%   assertFalse(CONDITION, MESSAGE) throws an exception containing the string
%   MESSAGE if CONDITION is not false.
%
%   MESSAGE is optional.
%
%   Examples
%   --------
%   assertFalse(isreal(sqrt(-1)))
%
%   assertFalse(isreal(sqrt(-1)), ...
%       'Expected isreal(sqrt(-1)) to be false.')

varargin = cellfun(@(p) InCoreDataContainer.stripicon(p),...
    varargin,'UniformOutput',false');
assertFalse(varargin{:});