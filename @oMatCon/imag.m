function y = imag(a)
%IMAG   Gives the imaginary part of oMatCon
%
if(~isa(a,'oMatCon'))
    error('Input parameter should be data container')
end
td = ConDir();
SeisDataContainer.io.memmap.serial.FileImag(path(a.pathname),path(td));    
y = oMatCon.load(td);
end
