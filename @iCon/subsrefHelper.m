function y = subsrefHelper(x,s)
%SUBSREFHELPER  Helper function for processing iCon subref
%
%   Interface that handles the propagation of header data in datacon.
%   Nothing the user needs to know here.
%

% Checking indices
% We need to extract a vector of indices for use in header subsref.
if length(s.subs) == 1 && all(s.subs{:} == ':') % Vectorizing case
    y = vec(x);
    return;
else % multiple dims case
    
    % indexing must be same # of dimensions as x
    assert(length(s.subs)==size(x.exsize,2),...
        'index must have the same ndims as the datacontainer')
    
    vectorized = false;
    colonized  = false;
    
    for i = length(s.subs):-1:1 % Start from slowest dimension
        % For index in every explicit dimension, do
        % case scalar c (single element)
        if isscalar(s.subs{i}) && isnumeric(s.subs{i})
            assert(~vectorized && ~colonized,...
                'May only use scalars to index over rightmost dimensions')
            
        % case vector a:b
        elseif isvector(s.subs{i}) && isnumeric(s.subs{i})
            assert(~colonized,...
                'Colon indexing cannot be used to the right of vectors');
            
            a = s.subs{i}(1);
            b = s.subs{i}(end);
            assert(length(s.subs{i}) == b - a + 1,...
                'Index skipping is not allowed');
            xdims = x.exsize(:,i);
            xdims = xdims';
            
            
            for j=1:length(xdims)-1
                c = x.header.size(xdims(j));
                assert(mod(a,c)==1 &&...
                       mod(b,c)==0,...
                    'Cross-dimensional indexing not allowed');           
            end
            
            vectorized = true;
            
        % case colon:
        elseif s.subs{i} == ':'
            
            colonized = true;
            
        % What??? I don't even...
        else
            error(['Unrecognized indexing' s.subs{i}]);
        end
        
    end
    
end

% Data processing
data = subsref(x.data,s);

% Repackage and export
y                      = construct(x,data);
y.header.delta         = x.header.delta(1:dims(y));
y.header.origin        = x.header.origin(1:dims(y));
y.header.precision     = x.header.precision;
y.header.complex       = x.header.complex;
y.header.unit          = x.header.unit(1:dims(y));
y.header.label         = x.header.label(1:dims(y));
y.header.distributedIO = x.header.distributedIO;