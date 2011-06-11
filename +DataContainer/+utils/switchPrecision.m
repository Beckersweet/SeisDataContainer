function x = switchPrecision(x,precision)
% getPrecision returns precision type of x as string
%
%   PRECISION = switchPrecision(X,PRECISION)
%           Supported precisions: 'double', 'single'
%
    assert(isfloat(x), 'data must be float')
    assert(ischar(precision), 'precision name must be a string')

    switch precision
        case 'single'
            if ~isa(x,'single'); x=single(x); end;
        case 'double'
	    if ~isa(x,'double'); x=double(x); end;
        otherwise
            error('Unsupported precision');
    end
end
