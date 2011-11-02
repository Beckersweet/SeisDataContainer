function y = getFirstStringIndex(varargin)
    y = 0;
    for i=1:nargin
        if(ischar(varargin{i}))
            y = i;
            break;
        end
    end
end

