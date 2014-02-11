function y = label(x,varargin)
    y = x.header.label;    
    
    if ~isempty(varargin)
        ind = spot.utils.uncell(varargin);
        
        y = y(ind);
    end
end

