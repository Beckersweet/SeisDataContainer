function varargout = subsref(x,s)
%SUBSREF   Subscripted reference.
%
%   X(a,b,..) - where a,b,.. are indices returns the explicit
%               elements stored within the data container as if it is a
%               Matlab array. Actually this level of subreferencing is
%               absolutely transparent. So don't expect a data container to
%               come out of this.
%
%   X(:)      - Returns a vectorized X. Note that doing this operation will
%               explicitly change all references to this object, including
%               the original, the copies and whatnot.
%
%   See also: iCon.vec, invvec, iCon.subsasgn

if length(s) > 1
    switch s(1).type
        case {'.'}
            % attributes references and function calls
            [output,done] = DataContainer.utils.subsrefFunctionCall(x,s);
            if done, return; end % For functions that don't return anything
            varargout{1}  = output;

        case {'{}'}
            error('Cell-indexing is not supported.');

        case {'()'}
            error('What youre doing now doesnt make any sense.');
    end
    
else
    switch s.type
        case {'.'}            
            % Set properties and flags
            varargout{1} = x.(s.subs);
            
        case {'{}'}
            error('Cell-indexing is not supported.');
            
        case {'()'} %This is where all the magic happens
            varargout{1} = subsref(double(x),s);
            
    end
end