function y = minus(A,B)
    if(isa(A,'oMatCon'))
        A = A.pathname;
    end
    if(isa(B,'oMatCon'))
        B = B.pathname;
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileMinus...
        (A,B,td);
    y  = oMatCon.load(td);
end