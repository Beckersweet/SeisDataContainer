function bytesize = getByteSize(precision)
% getByteSize returns bytsize for give PRECISION
%
%   BYTESIZE = getByteSize(PRECISION)
%   where PRECISION is a string specifying the precision of one unit of data,
%               Supported precisions: 'double', 'single'
%
    assert(ischar(precision), 'precision name must be a string')
    switch precision
        case 'single'
            bytesize = 4;
        case 'double'
            bytesize = 8;
        otherwise
            error('Unsupported precision');
    end
end
