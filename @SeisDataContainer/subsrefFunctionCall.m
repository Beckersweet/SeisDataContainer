function output = subsrefFunctionCall(x,s)
%SUBSREFFUNCTIONCALL   Subsref function call utility
%   For nonsimple functions with arguments included
%   Not supposed to be called by user, only by subsref
output = [];
switch s(1).subs
    case 'save'
        if(length(s(2).subs) == 2)
           save(x,cell2mat(s(2).subs(1)),cell2mat(s(2).subs(2)));
        else
           save(x,cell2mat(s(2).subs));
        end
        
    case 'modifyHeader'
        output = modifyHeader(x,s(2).subs{:});
        
    otherwise
%         warning('Function not officially supported');
        output = builtin('subsref',x,s);
end