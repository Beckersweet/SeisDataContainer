function varargout = subsref(x,s)
%SUBSREF   Subscripted reference.
%
%   X(a,b,..) - where a,b,.. are indices returns the explicit
%               elements stored within the data container as if it is a
%               Matlab array.
%
%   X(:)      - Returns a vectorized X. 
%
%   See also: iCon.vec, invvec, iCon.subsasgn

switch s(1).type
    case {'.'}            
        % attributes references and function calls
        if nargout > 0
            varargout{1:nargout} = builtin('subsref',x,s);
        else % function calls with no return value
            builtin('subsref',x,s);
        end

    case {'{}'}
        error('Cell-indexing is not supported.');

    case {'()'} % This is where all the magic happens
        if length(s) > 1
            error('Referencing from subsreffed components is not allowed');
        else
            varargout{1} = subsrefHelper(x,s);
        end
end