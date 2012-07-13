function y = reshape(x,varargin)
%RESHAPE    Reshape data container object to desired shape
%
%   reshape(X,N1,N2,...,N,VARARGIN) reshapes data container X into the
%   dimensions defined as [N1,N2,...,N]. Note that the number of elements
%   must be conserved.
%
%   Additional parameters:
%   'readonly' - 1 for readonly and 0 otherwise (default value is 1)
%   'copy'     - 0 for copy and 0 otherwise (default value is 0) 
%

% finding the index of first string input (if it exists)
stringIndex = SDCpckg.utils.getFirstStringIndex(varargin{:});

% Parsing inputs for readonly and copy case
p = inputParser;
p.addParamValue('readonly',1,@isscalar);
p.addParamValue('copy',0,@isscalar);

if(stringIndex)
    p.parse(varargin{stringIndex:end});
    shape = [varargin{1:stringIndex-1}];
else % default case
    p.parse();
    shape = [varargin{:}];
end

% making sure that we have the good input shape
if(prod(shape) ~= prod(size(x)))
    error('bad input shape: the number of elements should be preserved')
end

imsize  = x.header.size;

while(imsize(end) == 1) % Strip singleton dimensions
   imsize(end) = [];
end
j               = 1;
collapsed_chunk = [];
collapsed_dims  = 1;

for i = 1:length(imsize)
    collapsed_chunk = [collapsed_chunk imsize(i)];
    if  prod(collapsed_chunk) == shape(j)
        collapsed_dims(end+1)  = i;
        if i < length(imsize)
            collapsed_dims(end+1)  = i+1;
        end
        j = j + 1;
        collapsed_chunk = [];
    elseif prod(collapsed_chunk) > shape(j)
        error(['Reshape dimensions must be collapsed '...
            'or multiples of implicit dimension']);
    end
end

% loading the dataContainer
y        = oMatCon.load(...
    x.pathname,'readonly',p.Results.readonly,'copy',p.Results.copy);

% changing y.exsize = reshape(collapthe explicit size of the new dataContainer
y.exsize = reshape(collapsed_dims,2,[]);
% Vec case
if isvector(y.exsize)
    y.header.size(end+1) = 1;
    y.exsize(:,2) = [y.exsize(2,1)+1; y.exsize(2,1)+1];
end
end

