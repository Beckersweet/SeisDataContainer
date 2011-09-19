function y = power(A,B)
    if(isa(A,'oMatCon'))
        A = A.dirname;
    end
    if(isa(B,'oMatCon'))
        B = B.dirname;
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FilePower(A,B,td);    
    y = oMatCon.load(td);
end