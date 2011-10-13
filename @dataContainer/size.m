function y = size(x,dim)
    if(nargin == 2)
        if(isequal(class(x.header.size),'cell'))
            y = x.header.size(dim);
            y = cell2mat(y);
        else
            y = x.header.size(dim);
        end
    else
        if(isequal(class(x.header.size),'cell'))
            y = x.header.size;
            y = cell2mat(y);
        else
            y = x.header.size;
        end
    end
end
