function y = imag(a)
    if(~isa(a,'oMatCon'))
        error('Input parameter should be data container')
    end
    if(~a.header.complex)
        error('Epic fail: The dataContainer is not complex')
    end
    y = oMatCon.zeros(a.dimensions); 
    copyfile([a.dirname filesep 'imag'],y.dirname)
    headerOut = DataContainer.io.memmap.serial.HeaderRead(y.dirname);
    headerOut.complex = 1;
    DataContainer.io.memmap.serial.HeaderWrite(y.dirname,headerOut);
end