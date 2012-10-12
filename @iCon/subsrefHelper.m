function y = subsrefHelper(x,s)
%SUBSREFHELPER  Helper function for processing iCon subref
%
%   Interface that handles the propagation of header data in datacon.
%   Nothing the user needs to know here.
%

lastdim = length(s.subs);
% Checking indices
% We need to extract a vector of indices for use in header subsref.
if length(s.subs) == 1  % Vectorizing case
    if all(s.subs{:} == ':')
        y = vec(x);
        return;
    end
    
else % multiple dims case    
    % indexing must be same # of dimensions as x
    if ~(length(s.subs)==size(x.exsize,2))
        warning('iCon:IndexOutOfBounds',['You were using an indices with ',...
            'different number of dimensions as the data container??!! ',...
            'What were you thinking??? Metadata destroyed.']);
        y = construct(x,subsref(x.data,s));
        return;
    end
    
    vectorized = false;
    colonized  = false;
    
    for i = length(s.subs):-1:1 % Start from slowest dimension
        % For index in every explicit dimension, do
        % case scalar c (single element)
        if isscalar(s.subs{i}) && isnumeric(s.subs{i})
            if vectorized || colonized
                warning('iCon:ScalarRightMostDims',[ 'You have angered ',...
                    'the God of SeisDataContainer by using non-scalars ',...
                    'to index over the rightmost dimensions. Your metadata ',...
                    'has been sacrificed to appease His Containedness']);
                y = construct(x,x,subsref(x.data,s));
                return;
            end
            
            lastdim = lastdim - 1;
            
        % case vector a:b
        elseif isvector(s.subs{i}) && isnumeric(s.subs{i})
            if colonized
                warning('iCon:ColonRightOfVec',['Guess what cannot be ',...
                    'used right of vectors? colon indexing! Metadata ',...
                    'is destroyed']);
                y = construct(x,subsref(x.data,s));
                return;
            end
            
            a     = s.subs{i}(1);
            b     = s.subs{i}(end);
            xdims = x.exsize(:,i);
            xdims = xdims';
            
            % Check for index skipping
            if ~(length(s.subs{i}) == b - a + 1)
                warning('iCon:IndexSkipping',['You get into trouble when ',...
                    'you skip the line, so does your index. ',...
                    'Metadata is destroyed']);
                y = construct(x,subsref(x.data,s));
                return;
            end
            
            % a & b must mod cleanly with the products of faster dimensions
            for j=1:length(xdims)-1
                c = x.header.size(xdims(j));
                if ~(mod(a,c)==1 && mod(b,c)==0)
                    warning('iCon:CrossIndexingError',...
                    ['Weep in utter despair, for your metadata is ',...
                    'destroyed due to cross dimensional indexing']);
                    y = construct(x,subsref(x.data,s));
                    return;
                end
            end
            
            vectorized = true;
            
        % case colon:
        elseif s.subs{i} == ':'            
            colonized = true;
            
        % What??? I don't even...
        else
            warning('iCon:UnsupportedIndexing',...
            ['Take a deep breath, for you are venturing into ',...
            'unsupported indexing territory. All metadata is destroyed ',...
            'and made anew']);
            y = construct(x,subsref(x.data,s));
            return;
        end        
    end    
end

% Data processing
data = subsref(x.data,s);
%lastdim = lastdim - 1;

% Repackage and export
y                      = construct(x,data);
y.header.delta         = x.header.delta(1:lastdim);
y.header.origin        = x.header.origin(1:lastdim);
y.header.precision     = x.header.precision;
y.header.complex       = x.header.complex;
y.header.unit          = x.header.unit(1:lastdim);
y.header.label         = x.header.label(1:lastdim);
y.header.distributedIO = x.header.distributedIO;
