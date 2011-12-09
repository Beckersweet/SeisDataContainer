function y = power(a,b)
%POWER Calculates the power when at least one of a or b are oMatCon
%
aa = a;
bb = b;
if(isa(a,'oMatCon'))
    aa = path(a.pathname);
end
if(isa(b,'oMatCon'))
    bb = path(b.pathname);
end
td = ConDir();
DataContainer.io.memmap.serial.FilePower(aa,bb,path(td));    
y = oMatCon.load(td);
end