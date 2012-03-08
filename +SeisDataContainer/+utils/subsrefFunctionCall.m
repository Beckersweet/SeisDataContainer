function [output,done] = subsrefFunctionCall(x,s)
%SUBSREFFUNCTIONCALL   Subsref function call utility
%
%   Not supposed to be called by user, only by subsref
done   = false; % Flag for return
output = [];
switch s(1).subs
    case 'save'
        if(length(s(2).subs) == 2)
           save(x,cell2mat(s(2).subs(1)),cell2mat(s(2).subs(2)));
        else
           save(x,cell2mat(s(2).subs));
        end
        done   = true;
        
    case 'modifyHeader'
        args   = s(2).subs;
        output = modifyHeader(x,args{:});
        
    case 'header'
        header = x.header;
        output = subsref(header,s(2:end));
        
    otherwise
        warning('Function not officially supported');
        output = builtin('subsref', x, s);
        done   = true;
end