function y = mldivide(A,B,swp)
%MLDIVIDE Calculates the mldivide of the two input oMatCons

if isscalar(A) && isscalar(B)
    y = oMatCon.zeros(1);
    y.putFile({1},A.getFile({1})\B.getFile({1}));
else
    O = ConDir();
    DataContainer.io.memmap.serial.FileMldivide(A,path(B.pathname),path(O));
    y = oMatCon.load(O);
end
end
