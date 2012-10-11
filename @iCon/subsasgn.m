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

if length(s) > 1
    switch s(1).type
        case {'.'}
            x = builtin('subsasgn',x,s,b);
        case {'{}'}
            error('Cell-indexing is not supported.');
        case {'()'}
            error('Subsassignment to subsreffed components is not allowed');
    end % switch s(1).type
    return;
end % length(s) > 1

switch s(1).type
   case '.'
        % Set properties and flags
        x.(s.subs) = b;  

   case '{}'
      error('Cell-index access is not supported.');
 
   case '()'
       x.data = subsasgn(x.data,s,b);

end