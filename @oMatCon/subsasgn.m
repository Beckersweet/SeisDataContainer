function obj = subsasgn(obj,s,val)
%SUBSASGN   Subscripted assignment
%
    switch s(1).type
       case '.'
          obj = builtin('subsasgn',obj,s,val);
       case '()'
           if strcmp(class(val),'testSub')
              error('testSub:subsasgn',...
                   'Object must be scalar')
           elseif strcmp(class(val),'double')
               assignData.setStuff(s(1).subs,val);
           end
       otherwise
           error('Not a supported subscripted assignment');
   end
end