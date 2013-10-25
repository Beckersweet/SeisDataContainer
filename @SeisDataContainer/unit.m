function y = unit(x,varargin)
    y = x.header.unit;
    
    if ~isempty(varargin)
        len = length(varargin);
        % converting cell array of integers into double array
        ind = zeros(1,len);
        for i = 1 : len
            ind(i) = varargin{i};
        end
            
        y = y(ind);
    end
    
end

