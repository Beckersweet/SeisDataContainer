function y = complex(a,b)    
    if(isa(a,'oMatCon'))
        a = a.dirname;
    end
    if(isa(b,'oMatCon'))
        b = b.dirname;
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileComplex...
        (a,b,td);
    y  = oMatCon.load(td);
end
