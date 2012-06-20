function y = times(a,b)
%TIMES Calculates a*b when at least one of a or b are oMatCon
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
SDCpckg.io.NativeBin.serial.FileTimes...
    (aa,bb,path(td));
y  = oMatCon.load(td);
end
