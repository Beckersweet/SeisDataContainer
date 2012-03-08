function y = subsrefHelper(x,s)
%SUBSREFHELPER  Helper function for processing iCon subref
%
%   Interface that handles the propagation of header data in datacon.
%   Nothing the user needs to know here.
%
%

% Checking indices
indices  = s.subs;
dimslist = {1:sum(size(x))};
if length(indices) == 1 && indices{1} == ':' % vec case
    y = vec(x);
elseif
    
else
    
end

for i=1:length(tempsubs) && length(tempsubs) > 1
    assert(~strcmp(tempsubs{i},':'),...
        'Colon indexing only allowed on contiguous fast dimensions');
end

% Data processing
data = subsref(x.data,s);

% Header processing
xheader   = x.header;
neworigin = xheader.origin;
% for j = 1:length(indices)
%     neworigin(j) = xheader.origin(j) + (indices{j}-1)*xheader.delta(j);
% end

% Repackage and export
y                      = construct(x,data);
y.header.delta         = xheader.delta(1:dims(y));
y.header.origin        = neworigin(1:dims(y));
y.header.precision     = xheader.precision;
y.header.complex       = xheader.complex;
y.header.unit          = xheader.unit(1:dims(y));
y.header.label         = xheader.label(1:dims(y));
y.header.distributedIO = xheader.distributedIO;