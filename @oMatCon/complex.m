function y = complex(a,b)    
    if(isa(a,'oMatCon'))
        a = a.pathname;
    end
    if(isa(b,'oMatCon'))
        b = b.pathname;
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileComplex...
        (a,b,td);
    y  = oMatCon.load(td);
end
