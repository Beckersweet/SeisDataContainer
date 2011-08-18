function sref = subsref(obj,s)
    switch s(1).type
        case '.'
            sref = builtin('subsref',obj,s);
        case '()'
            sref = obj.getData(s(1).subs);
        otherwise
            error('Not a supported subscripted assignment');
    end
end