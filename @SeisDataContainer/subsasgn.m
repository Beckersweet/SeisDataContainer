function x = subsasgn(x,s,b)
%SUBSASGN   Subscripted assignment.
%
%   X(a,b,..) = A where A is a Matlab array and a,b,.. are indices that 
%               sets the explicit elements stored within the data container
%               as if it is a Matlab array. Actually this level of 
%               subsassignment is absolutely transparent. So don't pass in
%               a Data Container into a subsassignment operation.
%
%   See also: iCon.vec, invvec, iCon.subsref

switch s(1).type
    case '.'
        % Set properties and flags
        x = builtin('subsasgn',x,s,b);

    case '{}'
        error(['Unless you happen to have a Portal Gun, you are not ',...
          'accessing this Cell']);

    case '()'
        if length(s) > 1
           error(['Trying to assign to an subs-referenced item? ',...
               'Does humanity"s greed knows no bounds?']);
        else
            % Call each container's overloaded subsasgnHelper to fetch
            % actual data
            if ~isa(x, 'iCon')
                xc = iCon(x);
                xc = subsasgnHelper(xc, s, b);
                x = double(xc);
            else
                x = subsasgnHelper(x,s,b);
            end
        end
end