function y = minus(a,b)
%MINUS    Calculates a-b where at least one of a or b are oMatCon
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
DataContainer.io.memmap.serial.FileMinus...
    (aa,bb,path(td));
y  = oMatCon.load(td);
end
