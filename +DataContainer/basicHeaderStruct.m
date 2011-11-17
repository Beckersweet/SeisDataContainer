function header = basicHeaderStruct(xsize,xprecision,xcomplex,varargin)
% basicHeaderStruct creates the DataContainer header for MATLAB array
%
%   Required argumens:
%       XSIZE      - row vector with size(X)
%       XPRECISION - string holding the presision of X
%       XCOMPLEX   - scalar flag for complex X (0 for real or 1 for complex)
%
%   Optional keyword arguments:
%       'variable' - string holding the name of variable
%       'origin' - row vector holding the origin coordinate for ach axis
%       'delta' - row vector holding the delta of coordinate value for each axis
%       'unit' - cell array of strings with units for each axis
%       'label' - cell array of strings with label for each axis
%
%   EXAMPLE:
%       DataContainer.basicHeaderStruct([10 10],'double',1,...
%           'variable','test','origin',[1 2],'delta',[7 7],'unit',{'m','m'},'label',{'x','y'})
%
    header = struct();
    dims = length(xsize);

    header.variable = 'unknown';
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
    p.addParamValue('variable',header.variable,@ischar);
    p.addParamValue('origin',header.origin,@(x)isrow(x)&&length(x)==dims);
    p.addParamValue('delta',header.delta,@(x)isrow(x)&&length(x)==dims);
    p.addParamValue('unit',header.unit,@(x)iscell(x)&&length(x)==dims);
    p.addParamValue('label',header.label,@(x)iscell(x)&&length(x)==dims);
    p.parse(varargin{:});

    header.variable = p.Results.variable;
    header.origin = p.Results.origin;
    header.delta = p.Results.delta;
    header.unit = p.Results.unit;
    header.label = p.Results.label;

end
