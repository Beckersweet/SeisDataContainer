function x = modifyHeader(obj,varargin)
%MODIFYHEADER Modifies the header attributes and keeps the other header
%fields untouched
x = oMatCon.load(obj.pathname,varargin{:});
end

