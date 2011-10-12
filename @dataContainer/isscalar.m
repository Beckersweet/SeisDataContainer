function result = isscalar(x)
%ISSCALAR  Returns true if underlying data is a scalar
    if(prod(x.header.size) == 1)
        result = 1;
    else
        result = 0;
    end
end