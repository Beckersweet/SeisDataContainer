function y = intoout(data,varargin)
%INTOOUT In-core-to-out-of-core constructor for oMatCon
%   y = oMatCon.intoout(data,varargin) converts data, which can be either a
%   Matlab numeric array or iCon in-core data container into an oMatCon

if isa(data,'iCon')
    header = data.header;
    
    % Invvec to original sizes
    oldsize = size(data);% Keep old sizes
    if ~(header.size == oldsize)
        data = invvec(data);
    end
elseif isnumeric(data) && ~isa(data,'distributed')
    xsize = size(data);
    if isempty(varargin)
        xprecision = 'double';
    else
        p = inputParser;
        p.addParamValue('precision','double',@ischar);
        p.KeepUnmatched = true;
        p.parse(varargin);
        xprecision = p.Results.precision;
    end
    header = SDCpckg.basicHeaderStruct(xsize,xprecision,0);
else
    error('unsupported data type');
end

% Create condir
td     = ConDir();
% Actual writing of data into file
SDCpckg.io.NativeBin.serial.FileWrite(path(td),double(data),header);
if ~isempty(varargin)
    y = oMatCon.load(td,p.Unmatched);
else
    y = oMatCon.load(td);
end

% Reshape it back to the old size
if isa(data,'iCon')
    y = reshape(y,oldsize);
end