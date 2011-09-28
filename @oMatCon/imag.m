function y = imag(a)
    if(~isa(a,'oMatCon'))
        error('Input parameter should be data container')
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileImag(a.dirname,td);    
    y = oMatCon.load(td);
end