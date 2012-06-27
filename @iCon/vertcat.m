function y = vertcat(varargin)
%VERTCAT  Vertical concatenation.
%
%   [A; B] is the vertical concatenation of the data containers A and B.
%
%   See also iCon.horzcat

varargin = cellfun(@(x) SDCpckg.serial.stripicon(x),...
           varargin,'UniformOutput',false');
y = dataCon(vertcat(varargin{:}));