function y = unit(x,varargin)
    y = x.header.unit;
    
    if ~isempty(varargin)
        ind = spot.utils.uncell(varargin);
            
        y = y{ind};
    end
    
end

