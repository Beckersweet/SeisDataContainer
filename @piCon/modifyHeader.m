function x = modifyHeader(obj,varargin)
%MODIFYHEADER Modifies the header attributes and keeps the other header
%fields untouched
x = {piCon(double(obj),'header',obj.header,varargin{:}{:})};
end
