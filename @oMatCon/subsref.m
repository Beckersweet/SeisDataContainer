function sref = subsref(obj,s)
%SUBSREF   Subscripted reference
%   
    switch s(1).type
        case '.'
            if(strcmp(s(1).subs,'save'))
                obj.save(s(2).subs)
            elseif(strcmp(s(1).subs,'norm'))
                sref = obj.norm(s(2).subs);
            else
                sref = builtin('subsref',obj,s);
            end
        case '()'
            sref = obj.getFile(s(1).subs);
        otherwise
            error('Not a supported subscripted assignment');
    end
end