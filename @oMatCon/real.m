function y = real(a)
    if(~isa(a,'oMatCon'))
        error('Input parameter should be data container')
    end
    td = DataContainer.io.makeDir();
    DataContainer.io.memmap.serial.FileCopy(a.dirname,td);
    headerOut = DataContainer.io.memmap.serial.HeaderRead(td);
    if(headerOut.complex)        
        headerOut.complex = 0;
        delete([td filesep 'imag']);
        DataContainer.io.memmap.serial.HeaderWrite(td,headerOut);
    end
    y = oMatCon.load(td);    
end
