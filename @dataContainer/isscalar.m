function result = isscalar(x)
%ISSCALAR  Returns true if underlying data is a scalar
    if(prod(size(x)) == 1)
        result = 1;
    else
        result = 0;
    end
end