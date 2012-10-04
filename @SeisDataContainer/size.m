function varargout = size(x,varargin)
    
    y = zeros(1, size(x.exsize,2));
    for i=1:size(x.exsize,2)
        y(i) = prod(x.header.size(x.exsize(1,i):x.exsize(2,i)));
    end
    
    % Fill singleton dimensions
    if length(y) == 1
        y(1,2) = 1;
    end
    
    % Size indexing
    if ~isempty(varargin)
        y = y(varargin{:});
    end 
    
    if nargout == length(y)
        varargout = cell(1,length(y));
        for u = 1:length(y)
            varargout{u} = y(u);
        end
    else
        varargout{1} = y;
    end