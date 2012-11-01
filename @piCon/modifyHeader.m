function y = modifyHeader(obj,varargin)
%MODIFYHEADER Modifies the header attributes and keeps the other header
%fields untouched

y      = obj;
dims   = y.header.dims;
p      = inputParser;
p.addParamValue('varName',y.header.varName,@ischar);
p.addParamValue('varUnits',y.header.varUnits,@ischar);
p.addParamValue('origin',y.header.origin,@(x)isrow(x)&&length(x)==dims);
p.addParamValue('delta',y.header.delta,@(x)isrow(x)&&length(x)==dims);
p.addParamValue('unit',y.header.unit,@(x)iscell(x)&&length(x)==dims);
p.addParamValue('label',y.header.label,@(x)iscell(x)&&length(x)==dims);
p.parse(varargin{:});

y.header.varName  = p.Results.varName;
y.header.varUnits = p.Results.varUnits;
y.header.origin   = p.Results.origin;
y.header.delta    = p.Results.delta;
y.header.unit     = p.Results.unit;
y.header.label    = p.Results.label;

end
