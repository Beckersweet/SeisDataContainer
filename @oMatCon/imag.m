function y = imag(a)
    if(~isa(a,'oMatCon'))
        error('Input parameter should be data container')
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileImag(a.pathname,td);    
    y = oMatCon.load(td);
end