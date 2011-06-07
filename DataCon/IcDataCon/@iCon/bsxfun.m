function y = bsxfun(fun,A,B)
% BSXFUN  Binary Singleton Expansion Function
%   C = BSXFUN(FUNC,A,B) Apply an element-by-element binary operation to
%   arrays A and B, with singleton expansion enabled. FUNC is a
%   function handle. FUNC can either be a function handle for an 
%   M-function, or one of the following built-in functions:
%
%               @plus           Plus
%               @minus          Minus
%               @times          Array multiply
%               @rdivide        Right array divide
%               @ldivide        Left array divide
%               @power          Array power
%               @max            Binary maximum
%               @min            Binary minimum
%               @rem            Remainder after division
%               @mod            Modulus after division
%               @atan2	        Four-quadrant inverse tangent
%               @hypot	        Square root of sum of squares
%               @eq             Equal
%               @ne             Not equal
%               @lt             Less than
%               @le             Less than or equal
%               @gt             Greater than
%               @ge             Greater than or equal
%               @and            Element-wise logical AND
%               @or             Element-wise logical OR
%               @xor            Logical EXCLUSIVE OR
%
%   If an M-function is specified, the M-function must be able to 
%   accept as input either two column vectors of the same size, or
%   one column vector and one scalar, and return as output a column vector 
%   of the same size as the input(s). 
%   Each dimension of A and B must be equal to each other, or equal to one. 
%   Whenever a dimension of one of A or B is singleton (equal to 1), the array 
%   is virtually replicated along that dimension to match the other array 
%   (or diminished if the corresponding dimension of the other array is 0). 
%   The size of the output array C is equal to 
%   max(size(A),size(B)).*(size(A)>0 & size(B)>0). For 
%   example, if size(A)==[2 5 4] and size(B)==[2 1 4 3], then 
%   size(C)==[2 5 4 3].
%
%   Examples - Subtract the column means from the matrix A
%    
%     A = magic(5);
%     A = bsxfun(@minus, A, mean(A));


y = dataCon(bsxfun(fun,double(A),double(B)));

if isa(A,'iCon')
    y = metacopy(A,y);
elseif isa(B,'iCon')
    y = metacopy(B,y);
end