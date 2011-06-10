function precision = getPrecision(x)
% getPrecision returns precision type of x as string
%
%   PRECISION = getPrecision(X)
%           Supported precisions: 'double', 'single'
%
    assert(isfloat(x), 'data must be float')

    if isa(x,'single')
        precision = 'single';
    elseif isa(x,'double')
        precision = 'double';
    else
        error('Unsupported precision');
    end
end
