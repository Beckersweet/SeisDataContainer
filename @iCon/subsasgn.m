function x = subsasgn(x,s,b)
%SUBSASGN   Subscripted assignment.
%
%   X(a,b,..) = A where A is a Matlab array and a,b,.. are indices that 
%               sets the explicit elements stored within the data container
%               as if it is a Matlab array. Actually this level of 
%               subsassignment is absolutely transparent. So don't pass in
%               a Data Container into a subsassignment operation.
%
%   See also: iCon.vec, invvec, iCon.subsref

switch s.type
   case {'.'}
        % Set properties and flags
        x.(s.subs) = b;  

   case {'{}'}
      error('Cell-index access is not supported.');
 
   case {'()'}
       x.data = subsasgn(x.data,s,b);

end
