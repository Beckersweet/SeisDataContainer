function y = power(A,B)
    if(isa(A,'oMatCon'))
        A = A.pathname;
    end
    if(isa(B,'oMatCon'))
        B = B.pathname;
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FilePower(A,B,td);    
    y = oMatCon.load(td);
end