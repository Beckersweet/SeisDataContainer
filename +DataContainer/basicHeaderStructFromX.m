function header = basicHeaderStructFromX(x,varargin)
% basicHeaderStructFromX creates the DataContainer header from MATLAB array X
%
%   Required argumens:
%       X - MATLAB array
%
%   Optional keyword arguments:
%       'varname' - string holding the name of variable
%       'varunits' - string holding the units of variable
%       'origin' - row vector holding the origin coordinate for ach axis
%       'delta' - row vector holding the delta of coordinate value for each axis
%       'unit' - cell array of strings with units for each axis
%       'label' - cell array of strings with label for each axis
%
%   EXAMPLE:
%       DataContainer.basicHeaderStructFromX(rand(10),...
%           'varname','test','varunits','m/s','origin',[1 2],'delta',[7 7],'unit',{'m','m'},'label',{'x','y'})
%
    header = struct();
    xsize = size(x);
    xprecision = DataContainer.utils.getPrecision(x);
    xcomplex = ~isreal(x);
    dims = length(xsize);

    header.varname = 'unknown';
    header.varunits = 'unknown';
    header.dims = dims;
    header.size = xsize;
    header.origin = zeros(1,dims);
    header.delta = ones(1,dims);

    header.precision = xprecision;
    header.complex = xcomplex;

    for i=1:dims % units
        u(i) = {['u',int2str(i)]};
    end
    header.unit = u;
    for i=1:dims % labels
        l(i) = {['l',int2str(i)]};
    end
    header.label = l;

    header.distributed = 0;

    p = inputParser;
    p.addParamValue('varname',header.varname,@ischar);
    p.addParamValue('varunits',header.varunits,@ischar);
    p.addParamValue('origin',header.origin,@(x)isrow(x)&&length(x)==dims);
    p.addParamValue('delta',header.delta,@(x)isrow(x)&&length(x)==dims);
    p.addParamValue('unit',header.unit,@(x)iscell(x)&&length(x)==dims);
    p.addParamValue('label',header.label,@(x)iscell(x)&&length(x)==dims);
    p.parse(varargin{:});

    header.varname = p.Results.varname;
    header.varunits = p.Results.varunits;
    header.origin = p.Results.origin;
    header.delta = p.Results.delta;
    header.unit = p.Results.unit;
    header.label = p.Results.label;

end
