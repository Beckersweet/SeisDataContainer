function y = ldivide(a,b)
%LDIVIDE   Calculates the ldivide where at least one of a or b are oMatCon
%

if(isa(a,'oMatCon'))
    aa = path(a.pathname);
else
    aa = a;
end

if(isa(b,'oMatCon'))
    bb = path(b.pathname);
else
    bb = b;
end

td = ConDir();
SeisDataContainer.io.NativeBin.serial.FileLdivide(aa,bb,path(td));
y  = oMatCon.load(td);

if ~isa(a,'oMatCon') % Right divide
    y = metacopy(b,y);
            
elseif ~isa(b,'oMatCon') % Left divide
    y = metacopy(a,y);
    
else % Both data containers
    % Check for strict flag
    if a.strict || a.strict
       assert(all(a.header.size == b.header.size),...
           'Strict flag enforced. Implicit dimensions much match.')
    end
    
    y = metacopy(a,y);
end