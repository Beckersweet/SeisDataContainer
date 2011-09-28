function y = times(A,B)
    if(isa(A,'oMatCon'))
        A = A.dirname;
    end
    if(isa(B,'oMatCon'))
        B = B.dirname;
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileTimes...
        (A,B,td);
    y  = oMatCon.load(td);
end


