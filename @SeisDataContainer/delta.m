function y = delta(x,varargin)
    y = x.header.delta;
    
    if ~isempty(varargin)
        ind = spot.utils.uncell(varargin);
            
        y = y(ind);
    end
    
end


