function x = subsasgnHelper(x,s,b)
%SUBSASGNHELPER Helper function to assign oMatCon data
%
%   Users are not supposed to see this

if strcmp(class(b),'testSub')
   error('testSub:subsasgn',...
       'Object must be scalar')
elseif (strcmp(class(b),'iCon') || strcmp(class(b),'double'))
   x.putFile(s(1).subs,b);
end