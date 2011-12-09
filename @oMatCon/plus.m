function y = plus(a,b)
%PLUS Calculates the plus when at least one of a or b are oMatCon
%
aa=a;
bb=b;
if(isa(a,'oMatCon'))
    aa = path(a.pathname);
end
if(isa(b,'oMatCon'))
    bb = path(b.pathname);
end
td = ConDir();
DataContainer.io.memmap.serial.FilePlus...
    (aa,bb,path(td));
y  = oMatCon.load(td);
end