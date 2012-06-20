function y = switchPrecision(x,precision)
% getPrecision returns with new precision
%
%   Y = switchPrecision(X,PRECISION)
%           Supported precisions: 'double', 'single'
%
    assert(isfloat(x), 'data must be float')
    assert(ischar(precision), 'precision name must be a string')

    switch precision
        case 'single'
            if ~isa(x,'single'); y=single(x); end;
        case 'double'
            if ~isa(x,'double'); y=double(x); end;
        otherwise
            error('Unsupported precision');
    end
end
