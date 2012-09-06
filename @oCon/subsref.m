function sref = subsref(obj,s)
%SUBSREF   Subscripted reference
%
switch s(1).type
    case '.'
        if(strcmp(s(1).subs,'save'))
            if(length(s(2).subs) == 2)
                obj.save(cell2mat(s(2).subs(1)),cell2mat(s(2).subs(2)));
            else
                obj.save(cell2mat(s(2).subs));
            end
        elseif(strcmp(s(1).subs,'norm'))
            if(length(s(2).subs) == 1)
                sref = obj.norm(cell2mat(s(2).subs(1)));
            else
                sref = obj.norm();
            end
        else
            sref = builtin('subsref',obj,s);
        end
    case '()'
        sref = obj.getFile(s(1).subs);
    otherwise
        error('Not a supported subscripted assignment');
end
end