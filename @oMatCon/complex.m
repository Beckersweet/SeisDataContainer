function y = complex(a,b)
    td = DataContainer.io.makeDir();
    if(isa(a,'oMatCon'))
        a = a.dirname;
    end
    if(isa(b,'oMatCon'))
        b = b.dirname;
    end
    DataContainer.io.memmap.serial.FileComplex...
        (a,b,td);
    y  = oMatCon.load(td);
end

