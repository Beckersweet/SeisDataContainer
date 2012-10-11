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

switch s(1).type
   case '.'
        % Set properties and flags
        x = builtin('subsasgn',x,s,b);

   case '{}'
      error('Cell-index access is not supported.');
 
   case '()'
       if length(s) > 1
           error('Subsassignment to subsreffed components is not allowed');
       else
           x.data = subsasgn(x.data,s,b);
       end
end