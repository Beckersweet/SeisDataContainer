function y = subsrefHelper(x,s)
%SUBSREFHELPER  Helper function for processing iCon subref
%
%   Nothing the user needs to know here.
%
%

% Checking indices
tempsubs = s.subs;
while strcmp(tempsubs{1},':')
    tempsubs = tempsubs(2:end);
end
for i=1:length(tempsubs)
    assert(~strcmp(tempsubs{i},':'),...
        'Colon indexing only allowed on contiguous fast dimensions');
end

% Data processing
data = subsref(x.data,s);

% Header processing
xheader   = x.header;
neworigin = xheader.origin; % NEEDS TO CALCULATE NEW ORIGIN

% Repackage and export
y                      = construct(x,data);
y.header.delta         = xheader.delta;
y.header.origin        = neworigin;
y.header.precision     = xheader.precision;
y.header.complex       = xheader.complex;
y.header.unit          = xheader.unit(1:dims(y));
y.header.label         = xheader.label(1:dims(y));
y.header.distributedIO = xheader.distributedIO;