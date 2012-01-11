function y = vec(x)
%VEC   Gives the vector form of oMatCon. This fuction reshapes an 
%M-by-N-by-P-by-... oMatCon to a M*N*P*...-by-1 oMatCon
%
y = reshape(x,[prod(size(x)) 1]);
end
