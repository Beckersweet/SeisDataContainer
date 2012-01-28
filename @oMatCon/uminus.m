function y = uminus(a)
%UMINUS   Unary minus
%   -A negates the elements of A
%
aa = a;
if(isa(a,'oMatCon'))
    aa = path(a.pathname);
end
td = ConDir();
SeisDataContainer.io.NativeBin.serial.FileTimes...
    (-1,aa,path(td));
y  = oMatCon.load(td);
end
