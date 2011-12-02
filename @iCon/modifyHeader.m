function x = modifyHeader(obj,varargin)
%MODIFYHEADER Modifies the header attributes and keeps the other header
%fields untouched
x = {iCon(double(obj),'header',obj.header,varargin{:}{:})};
end
