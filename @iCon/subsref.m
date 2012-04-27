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

if length(s) > 1
    switch s(1).type
        case {'.'}
            % attributes references and function calls
            varargout{:} = subsrefFunctionCall(x,s);

        case {'{}'}
            error('Cell-indexing is not supported.');

        case {'()'}
            error('Referencing from subsreffed components is not allowed');
    end
    
else % length(s) == 1
    switch s.type
        case {'.'}            
            % Set properties and flags
            varargout{1} = x.(s.subs);
            
        case {'{}'}
            error('Cell-indexing is not supported.');
            
        case {'()'} %This is where all the magic happens
            varargout{1} = subsrefHelper(x,s);
            
    end
end