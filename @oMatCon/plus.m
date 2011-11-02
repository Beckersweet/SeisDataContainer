function y = plus(A,B)
    if(isa(A,'oMatCon'))
        A = A.pathname;
    end
    if(isa(B,'oMatCon'))
        B = B.pathname;
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FilePlus...
        (A,B,td);
    y  = oMatCon.load(td);
end