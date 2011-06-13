function precision = getPrecision(x)
% getPrecision returns precision type of x as string
%
%   PRECISION = getPrecision(X)
%           Supported precisions: 'double', 'single'
%
    assert(isfloat(x) | isdistributed(x), 'data must be float or distributed')

    if isdistributed(x)
        if isaUnderlying(x,'single')
            precision = 'single';
        elseif isaUnderlying(x,'double')
            precision = 'double';
        else
            error('Unsupported precision');
        end
    else
        if isa(x,'single')
            precision = 'single';
        elseif isa(x,'double')
            precision = 'double';
        else
            error('Unsupported precision');
        end
    end
end
