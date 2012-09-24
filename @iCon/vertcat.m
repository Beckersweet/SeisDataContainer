function y = vertcat(varargin)
%VERTCAT  Vertical concatenation.
%
%   [A; B] is the vertical concatenation of the data containers A and B.
%
%   See also iCon.horzcat

varargin = cellfun(@(x) SDCpckg.serial.stripicon(x),...
           varargin,'UniformOutput',false');
y = vertcat(varargin{:});
if isa(y, 'distributed')
    y = piCon(y);
else
    y = iCon(y);
end