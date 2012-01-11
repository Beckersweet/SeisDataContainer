function x = modifyHeader(obj,varargin)
%MODIFYHEADER Modifies the header attributes and keeps the other header
%fields untouched

x = obj;

% parse extra arguments
ldims = length(x.header.size);
p = inputParser;
p.addParamValue('varName',x.header.varName,@ischar);
p.addParamValue('varUnits',x.header.varUnits,@ischar);
p.addParamValue('origin',x.header.origin,@(x)isrow(x)&&length(x)==ldims);
p.addParamValue('delta',x.header.delta,@(x)isrow(x)&&length(x)==ldims);
p.addParamValue('unit',x.header.unit,@(x)iscell(x)&&length(x)==ldims);
p.addParamValue('label',x.header.label,@(x)iscell(x)&&length(x)==ldims);
p.parse(varargin{:});
x.header.varName  = p.Results.varName;
x.header.varUnits = p.Results.varUnits;
x.header.origin   = p.Results.origin;
x.header.delta    = p.Results.delta;
x.header.unit     = p.Results.unit;
x.header.label    = p.Results.label;

end
