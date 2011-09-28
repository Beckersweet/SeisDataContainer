function y = real(a)
    if(~isa(a,'oMatCon'))
        error('Input parameter should be data container')
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileReal(a.dirname,td);    
    y = oMatCon.load(td);
end
