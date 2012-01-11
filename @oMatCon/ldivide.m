function y = ldivide(a,b)
%LDIVIDE   Calculates th ldivide where at least on of a or b are oMatCon
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
DataContainer.io.memmap.serial.FileLdivide...
    (aa,bb,path(td));
y  = oMatCon.load(td);
end
