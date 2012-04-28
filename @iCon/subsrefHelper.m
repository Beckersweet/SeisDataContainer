function y = subsrefHelper(x,s)
%SUBSREFHELPER  Helper function for processing iCon subref
%
%   Interface that handles the propagation of header data in datacon.
%   Nothing the user needs to know here.
%

% Checking indices
% We need to extract a vectors of indices for use in header subsref.
if length(s.subs) == 1 && all(s.subs{:} == ':') % Vectorizing case
    
else % multiple dims case
    for i = 1:length(s.subs)
        assert(length(s.subs{i}) == s.subs{i}(end)-s.subs{i}(1) + 1,...
            'Index skipping is not allowed');
    end
    
    if length(s.subs) == 1 %Vector case
        % Finding which dimension is sliced
        k = 1;
        d = (s.subs{:}(end)-s.subs{:}(1)+1)/prod(size(x,1:k));
        while d > 1
            k = k + 1;
            d = (s.subs{:}(end)-s.subs{:}(1)+1)/prod(size(x,1:k));
        end
        
        % Assert the contiguousness of the faster dimensions
        assert(mod(s.subs{:}(1),prod(size(x,1:k-1))) == 1,...
            'Cannot skip faster dimensions');
        assert(mod(s.subs{:}(end),prod(size(x,1:k-1))) == 0,...
            'Cannot skip faster dimensions');
        
    elseif length(s.subs) == 2 %multivector
        
    else
%         error('Index dimensions not supported');
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