function y = rdivide(a,b)
%RDIVIDE Calculates the rdivide when at least one of a or b are oMatCon
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
SeisDataContainer.io.memmap.serial.FileRdivide...
    (aa,bb,path(td));
y  = oMatCon.load(td);
end
