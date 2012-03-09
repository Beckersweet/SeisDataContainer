function y = subsrefHelper(x,s)
%SUBSREFHELPER  Helper function for processing iCon subref
%
%   Interface that handles the propagation of header data in datacon.
%   Nothing the user needs to know here.
%

% Checking indices
% We need to extract a vectors of indices for use in header subsref.
subs  = s.subs;
indices = zeros(1,dims(x));
if length(subs) == dims(x) % Number of indices is same as dimensions.
    
elseif subs{end} == ':'
        
else

end

% Data processing
data = subsref(x.data,s);

% Header processing
xheader   = x.header;
neworigin = xheader.origin;

% Repackage and export
y                      = construct(x,data);
y.header.delta         = xheader.delta(1:dims(y));
y.header.origin        = neworigin(1:dims(y));
y.header.precision     = xheader.precision;
y.header.complex       = xheader.complex;
y.header.unit          = xheader.unit(1:dims(y));
y.header.label         = xheader.label(1:dims(y));
y.header.distributedIO = xheader.distributedIO;