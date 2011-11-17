function y = real(a)
    if(~isa(a,'oMatCon'))
        error('Input parameter should be data container')
    end
    td = ConDir();
    DataContainer.io.memmap.serial.FileReal(path(a.pathname),path(td));    
    y = oMatCon.load(td);
end
