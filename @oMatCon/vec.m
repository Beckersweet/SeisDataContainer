function y = vec(x)
    y = reshape(x,[prod(size(x)) 1]);
end

