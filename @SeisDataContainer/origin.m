function y = origin(x,varargin)
    y = x.header.origin;
    
    if ~isempty(varargin)
        ind = spot.utils.uncell(varargin);
        
        y = y(ind);
    end
end

