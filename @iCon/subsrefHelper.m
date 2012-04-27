function y = subsrefHelper(x,s)
%SUBSREFHELPER  Helper function for processing iCon subref
%
%   Interface that handles the propagation of header data in datacon.
%   Nothing the user needs to know here.
%

% Checking indices
% We need to extract a vectors of indices for use in header subsref.
if length(s.subs) == 1 && s.subs{end} == ':' % Vectorizing case
    
else % multiple dims case
    for i = 1:length(s.subs)
        assert(length(s.subs{i}) == s.subs{i}(end)-s.subs{i}(1) + 1,...
            'Index skipping is not allowed');
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