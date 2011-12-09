function y = mrdivide(A,B)
%POWER Calculates the mrdivide when at least one of a or b are oMatCon
%
if isscalar(A) && isscalar(B)
    y = oMatCon.zeros(1);
    y.putFile({1},A.getFile({1})/B.getFile({1}));
else
    sizeB = size(B);
    if(length(sizeB) > 2 || sizeB(1) ~= sizeB(2))
        error('Error: Second parameter should be 2D and n-by-n');
    end
    y = (B'\A')';   
end
end

