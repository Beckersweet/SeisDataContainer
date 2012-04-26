function y = subsrefHelper(x,s)
%SUBSREFHELPER  Helper function for processing iCon subref
%
%   Interface that handles the propagation of header data in datacon.
%   Nothing the user needs to know here.
%

% Checking indices
% We need to extract a vectors of indices for use in header subsref.
ind = zeros(dims(x),2); % Start and end indices for each dimension
if length(s.subs) == 1 && s.subs{end} == ':' % Vectorizing case
    for i = 1:dims(x)
        ind(i,1) = 1;
        ind(i,2) = size(x,i);
    end
elseif length(s.subs) <= dims(x) && s.subs{end} ~= ':' % No right fills
    % Number of left dimensions.
    for i = 1:length(s.subs)
        if s.subs{i} == ':'
            ind(i,1) = 1;
            ind(i,2) = size(x,i);
        else
            ind(i,1) = s.subs{i}(1);
            ind(i,2) = s.subs{i}(end);
        end
    end
else
    error('This kind of indexing is not supported');
end

% Data processing
data = subsref(x.data,s);

% Repackage and export
y                      = construct(x,data);
y.header.delta         = xheader.delta();
y.header.origin        = neworigin(1:dims(y));
y.header.precision     = xheader.precision;
y.header.complex       = xheader.complex;
y.header.unit          = xheader.unit(1:dims(y));
y.header.label         = xheader.label(1:dims(y));
y.header.distributedIO = xheader.distributedIO;