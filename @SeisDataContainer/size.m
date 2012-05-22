function y = size(x,varargin)
    
    y = zeros(1, size(x.exsize,2));
    for i=1:size(x.exsize,2)
        y(i) = prod(x.header.size(x.exsize(1,i):x.exsize(2,i)));
    end
    
    if ~isempty(varargin)
        y = y(varargin{:});
    end
end
