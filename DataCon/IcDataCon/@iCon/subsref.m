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
%     % Check for extended function calls
%     if strcmp(s(1).type,'.')
%         subs = [s.subs];
%         varargout{1} = feval(subs{1},x,subs{2:end});        
%     else
%         varargout = builtin('subsref',x,s);
       result = x;
       for i=1:length(s)
          if iscell(result)
             if strcmp(s(i).type,'{}')
                result = builtin('subsref',result,s(i));
             else
                % Apply the subsref to each element
                newresult = cell(1,length(result));
                for j=1:length(result)
                   newresult{j} = subsref(result{j},s(i));
                end
                result = newresult;
             end
          else
             result = subsref(result,s(i));
          end
       end
    
       if nargout > 1
          for i=2:nargout
             varargout{i} = [];
          end
       end
       varargout{1} = result;
    
       return;
%     end
    
else
    
    switch s.type
        case {'.'}
            % Set properties and flags
            varargout{1} = x.(s.subs);
            
        case {'{}'}
            error('Cell-indexing is not supported.');
            
        case {'()'}
            varargout{1} = subsref(double(x),s);
            
    end
end
