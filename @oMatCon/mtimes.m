function y = mtimes(A,B)
%MTIMES Calculates the mtimes of the two input oMatCons
%
if isscalar(A) && isscalar(B)
    y = oMatCon.zeros(1);
    y.putFile({1},A.getFile({1})*B.getFile({1}));
else
    td = ConDir();
    SeisDataContainer.io.NativeBin.serial.FileMtimes...
        (A,path(B.pathname),path(td));
    y = oMatCon.load(td);
end
end
